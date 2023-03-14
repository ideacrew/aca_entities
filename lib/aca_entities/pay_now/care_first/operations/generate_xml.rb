# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'aca_entities/pay_now/care_first'

module AcaEntities
  module PayNow
    module CareFirst
      module Operations
        # Create embedded XML payload for CareFirst Pay Now implementation
        class GenerateXml
          include Dry::Monads[:result, :do, :try]

          def call(payload)
            _validated_enrollment = yield validate_enrollment(payload)
            _validated_members = yield validate_members(payload)
            transformed_payload = yield transform_payload(payload)
            validated_transformed_payload = yield validate_transformed_payload(transformed_payload)
            entity = yield initialize_entity(validated_transformed_payload)
            serialized_payload = yield to_serialized_obj(entity)
            xml_payload = yield to_xml(serialized_payload)
            Success(xml_payload)
          end

          private

          def validate_enrollment(payload)
            enrollment = payload.dig(:coverage_and_members, :hbx_enrollment)
            return Failure("missing :hbx_enrollment in payload") unless enrollment

            result = AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.new.call(enrollment)
            result.success? ? result : Failure("HbxEnrollmentContract -> #{result.errors.to_h}")
          end

          def validate_members(payload)
            members = payload.dig(:coverage_and_members, :members)
            return Failure("missing :members in payload") unless members

            failures = members.inject([]) do |results, member|
              result = AcaEntities::Contracts::People::PersonContract.new.call(member)
              next results if result.success?

              results << "hbx_id: #{member[:hbx_id]} - #{result.errors.to_h}"
            end

            failures.empty? ? Success(payload) : Failure("PersonContract -> #{failures}")
          end

          def transform_payload(payload)
            prepped_record = prep_record(payload)
            result = ::AcaEntities::PayNow::CareFirst::Transformers::CoverageAndMembers.transform(prepped_record)
            Success(result[:pay_now_transfer_payload])
          rescue StandardError => e
            Failure("CoverageAndMembers transformer #{e}")
          end

          def prep_record(payload)
            enr_subscriber = payload[:coverage_and_members][:hbx_enrollment][:hbx_enrollment_members].detect {|member| member[:is_subscriber]}
            primary_person = payload[:coverage_and_members][:members].detect do |member|
              member[:hbx_id] == enr_subscriber[:family_member_reference][:person_hbx_id]
            end
            payload[:coverage_and_members][:members].each do |member|
              relationship = primary_person[:person_relationships].detect { |rel| rel[:relative][:hbx_id] == member[:hbx_id] }
              relationship_kind = relationship.present? ? relationship[:kind] : 'self'
              member[:relationship_to_primary] = relationship_kind
              member[:is_subscriber] = enr_subscriber[:person_hbx_id] == member[:hbx_id]
            end
            payload[:coverage_and_members][:primary_person] = primary_person
            payload
          end

          def validate_transformed_payload(params)
            result = Try do
              AcaEntities::PayNow::CareFirst::Contracts::PayNowTransferPayloadContract.new.call(params)
            end.to_result

            result.success? ? result : Failure("PayNowTransferPayloadContract -> #{result.failure.errors.to_h}")
          end

          def initialize_entity(payload)
            result = Try do
              AcaEntities::PayNow::CareFirst::PayNowTransferPayload.new(payload.to_h)
            end.to_result

            result.success? ? result : Failure("entity-PayNowTransferPayload -> #{result.failure}")
          end

          def to_serialized_obj(entity)
            seralized_xml = Try do
              AcaEntities::Serializers::Xml::PayNow::CareFirst::PayNowTransferPayload.domain_to_mapper(entity)
            end.to_result

            seralized_xml.success? ? seralized_xml : Failure("Serializers-PayNowTransferPayload -> #{seralized_xml.failure}")
          end

          def to_xml(serialized_payload)
            xml_with_root_tag = serialized_payload.to_xml
            doc = Nokogiri::XML(xml_with_root_tag)
            root_node = doc.at_xpath('/PayNowTransferPayload')

            Success(root_node.children.to_xml)
          rescue StandardError => e
            Failure("AcaEntities::PayNow::CareFirst::Operations::GenerateXml to_xml -> #{e}")
          end
        end
      end
    end
  end
end