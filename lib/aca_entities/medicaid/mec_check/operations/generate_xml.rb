# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

require 'aca_entities/medicaid/mec_check'

module AcaEntities
  module Medicaid
    module MecCheck
      module Operations
        # MecCheck operation to create valid XML from payload
        class GenerateXml
          include Dry::Monads[:result, :do, :try]

          def call(payload)
            record = yield parse_payload(payload)
            mc_payload = yield to_mec_check(record)
            validated_payload = yield validate_mec_check(mc_payload)
            entity = yield initialize_entity(validated_payload)
            serialized_payload = yield to_serialized_obj(entity, record["request_for"])
            xml_payload = serialized_payload.to_xml
            Success(xml_payload)
          end

          private

          def validate_mec_check(params)
            result = Try do
              AcaEntities::Medicaid::MecCheck::Contracts::VerifyNonEsiMecRequestContract.new.call(params["verify_non_esi_mec_request"])
            end.to_result

            if result.success?
              result
            else
              Failure("VerifyNonEsiMecRequestContract -> #{result.failure.errors.to_h}")
            end
          end

          def initialize_entity(payload)
            result = Try do
              AcaEntities::Medicaid::MecCheck::VerifyNonEsiMecRequest.new(payload.to_h)
            end.to_result

            if result.success?
              result
            else
              Failure("entity-VerifyNonEsiMecRequest -> #{result.failure}")
            end
          end

          def to_serialized_obj(entity, request_for)
            seralized_xml = Try do
             if request_for == "aces"
              AcaEntities::Serializers::Xml::Medicaid::MecCheck::VerifyNonEsiMecRequest.domain_to_mapper(entity)
             else
              entity_hash = entity.to_h[:non_esi_mec_request][:non_esi_mec_individual_information]
              AcaEntities::Serializers::Xml::Medicaid::MecCheck::GetEligibilityIndividualInformation.domain_to_mapper(entity_hash)
             end
            end.to_result

            if seralized_xml.success?
              seralized_xml
            else
              Failure("Serializers-MecCheck -> #{seralized_xml.failure}")
            end
          end

          def parse_payload(payload)
            record = JSON.parse(payload)
            Success(record)
          rescue StandardError => e
            Failure("Could not parse the payload #{e}")
          end

          def to_mec_check(record)
            result = ::AcaEntities::Medicaid::MecCheck::Transformers::PersonToRequest.transform(record)
            top_hash = {}
            top_hash["verify_non_esi_mec_request"] = result
            Success(top_hash)
          rescue StandardError => e
            Failure("to_mec_check transformer #{e}")
          end
        end
      end
    end
  end
end