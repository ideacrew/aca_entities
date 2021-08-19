# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

# lib/aca_entities/medicaid/contracts
require 'aca_entities/medicaid/atp'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'
require 'aca_entities/atp/transformers/aces/family'

module AcaEntities
  module Atp
    module Operations
      module Aces
        # Family Operations for atp payloads
        class GenerateXml
          include Dry::Monads[:result, :do, :try]

          def call(payload)
            valid_payload = yield validate(payload)
            aces_payload = yield to_aces(valid_payload)
            valid_aces_payload = yield validate_aces(aces_payload)
            entity = yield initialize_entity(valid_aces_payload)
            serialized_payload = yield to_serialized_obj(entity)
            _result = yield validate_xml(serialized_payload)

            xml_payload = serialized_payload.to_xml
            Success(xml_payload)
          end

          private

          def validate(params)
            Success(params)
          end

          def validate_aces(params)
            result = Try do
              AcaEntities::Medicaid::Contracts::AccountTransferRequestContract.new.call(params[:aces])
            end.to_result

            if result.success?
              result
            else
              Failure("AccountTransferRequestContract -> #{result.failure.errors.to_h}")
            end
          end

          def initialize_entity(payload)
            result = Try do
              AcaEntities::Medicaid::Atp::AccountTransferRequest.new(payload.to_h)
            end.to_result

            if result.success?
              result
            else
              Failure("entity-AccountTransferRequest -> #{result.failure}")
            end
          end

          def to_serialized_obj(entity)
            seralized_xml = Try do
              AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.domain_to_mapper(entity)
            end.to_result

            if seralized_xml.success?
              seralized_xml
            else
              Failure("Serializers-AccountTransferRequest -> #{seralized_xml.failure}")
            end
          end

          def validate_xml(seralized_xml)
            document = Nokogiri::XML(seralized_xml.to_xml)
            xsd_path = File.open('/Users/vishu/new_repo/gem/aca_entities/lib/aca_entities/atp/schema/aces/atp_service.xsd')
            schema_location = File.expand_path(xsd_path)
            schema = Nokogiri::XML::Schema(File.open(schema_location))
            result = schema.validate(document).each_with_object([]) do |error, collect|
              collect << error.message
            end

            if result.empty?
              Success(true)
            else
              Failure("validate_xml -> #{result}")
            end
          end

          def to_aces(payload)
            record = JSON.parse(payload)
            family_members = record["family"]["family_members"]
            record["family"].merge!("family_members" => family_members.group_by do |h|
                                                          h["person"]["hbx_id"]
                                                        end.transform_keys(&:to_s).transform_values(&:first))
            applicants = record["family"]["magi_medicaid_applications"].first["applicants"]
            record["family"]["magi_medicaid_applications"].first.merge!("applicants" => applicants.group_by do |h|
                                                                                          h["person_hbx_id"]
                                                                                        end.transform_keys(&:to_s).transform_values(&:first))
            magi_medicaid_application = record["family"]["magi_medicaid_applications"].first
            record["family"].merge!("magi_medicaid_applications" => magi_medicaid_application)
            family_members = record["family"].delete("family_members")

            family_members.each do |family_member|
              person_relationships = family_member[1]["person"].delete("person_relationships")
              family_member[1]["person"].merge!("person_relationship" => person_relationships.first)

              person = family_member[1].delete("person")
              family_member[1].merge!("person" => person)
            end
            record["family"].merge!("family_members" => family_members)
            result = ::AcaEntities::Atp::Transformers::Aces::Family.transform(record)
            Success(result)
          rescue StandardError => e
            Failure("to_aces transformer #{e}")
          end
        end
      end
    end
  end
end
