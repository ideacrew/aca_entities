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
            transformed_payload = yield transform_payload(payload)
            validated_payload = yield validate_payload(transformed_payload)
            entity = yield initialize_entity(validated_payload)
            serialized_payload = yield to_serialized_obj(entity)
            xml_payload = serialized_payload.to_xml
            Success(xml_payload)
          end

          private

          def transform_payload(payload)
            result = ::AcaEntities::PayNow::CareFirst::Transformers::CoverageAndMembers.transform(payload)
            Success(result[:pay_now_transfer_payload])
          rescue StandardError => e
            Failure("CoverageAndMembers transformer #{e}")
          end

          def validate_payload(params)
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
        end
      end
    end
  end
end