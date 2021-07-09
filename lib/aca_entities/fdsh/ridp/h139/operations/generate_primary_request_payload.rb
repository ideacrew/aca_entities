# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Ridp
      module Operations
        # This class takes AcaEntities::Families::Famlily as input and returns the ridp primary request hash.
        class GeneratePrimaryRequestPayload
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Ridp Primary Request Payload
          # @return [Dry::Monads::Result]
          def call(person)
            valid_person              = yield validate_person(person)
            primary_request_params    = yield transform_person_to_primary_request(valid_person)
            validated_primary_request = yield validate_primary_request(primary_request_params)
            primary_request_json      = yield primary_request_entity_json(validated_primary_request)

            Success(primary_request_json)
          end

          private

          # Validate input object
          def validate_person(person)
            if person.is_a?(::AcaEntities::People::Person)
              Success(person)
            else
              Failure("Invalid person, given value is not a AcaEntities::People::Person, input_value:#{person}")
            end
          end

          # Transform Person params To PrimaryRequest Contract params
          def transform_person_to_primary_request(person)
            input_hash = person.to_h.merge({ home_address: person.home_address.to_h, home_phone: person.home_phone.to_h })
            ::AcaEntities::Fdsh::Transformers::Ridp::PersonToPrimaryRequest.call(input_hash.to_json) { |record| @transform_result = record }
            Success(@transform_result)
          end

          # Validate PrimaryRequest params against PrimaryRequest Contract
          def validate_primary_request(params)
            params.merge!({ LevelOfProofingCode: "LevelThree" })
            result = ::AcaEntities::Fdsh::Ridp::H139::PrimaryRequestContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          def primary_request_entity_json(values)
            result = ::AcaEntities::Fdsh::Ridp::H139::PrimaryRequest.new(values.to_h)

            Success(result)
          end
        end
      end
    end
  end
end
