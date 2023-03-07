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
            # record = yield parse_payload(payload)
            transformed_payload = yield transform_payload(payload)
            validated_payload = yield validate_payload(transformed_payload)
            entity = yield initialize_entity(validated_payload)
            serialized_payload = yield to_serialized_obj(entity)
            xml_payload = serialized_payload.to_xml
            Success(xml_payload)
          end

          private

          def validate_payload(params)
            result = Try do
              AcaEntities::PayNow::CareFirst::Contracts::PayNowTransferPayloadContract.new.call(params)
            end.to_result

            if result.success?
              result
            else
              Failure("PayNowTransferPayloadContract -> #{result.failure.errors.to_h}")
            end
          end

          def initialize_entity(payload)
            result = Try do
              AcaEntities::PayNow::CareFirst::PayNowTransferPayload.new(payload.to_h)
            end.to_result

            if result.success?
              result
            else
              Failure("entity-VerifyNonEsiMecRequest -> #{result.failure}")
            end
          end

          def to_serialized_obj(entity)
            seralized_xml = Try do
              AcaEntities::Serializers::Xml::Medicaid::MecCheck::PayNowTransferPayload.domain_to_mapper(entity)
            end.to_result

            if seralized_xml.success?
              seralized_xml
            else
              Failure("Serializers-PayNowTransferPayload -> #{seralized_xml.failure}")
            end
          end

        #   def parse_payload(payload)
        #     record = JSON.parse(payload)
        #     Success(record)
        #   rescue StandardError => e
        #     Failure("Could not parse the payload #{e}")
        #   end

          def transform_payload(payload)
            result = ::AcaEntities::PayNow::CareFirst::Transformers::CoverageAndMembers.transform(payload)
            # top_hash = {}
            # top_hash["verify_non_esi_mec_request"] = result
            # Success(top_hash)
            result.success? ? result : Failure("Transform failure: #{result.failure}")
          rescue StandardError => e
            Failure("to_mec_check transformer #{e}")
          end
        end
      end
    end
  end
end