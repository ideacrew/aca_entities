# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Operations
      module Ridp
        # This class takes AcaEntities::Families::Famlily as input and returns the ridp secondary request hash.
        class GenerateSecondaryRequestPayload
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Ridp secondary Request Payload
          # @return [Dry::Monads::Result]
          def call(family)
            valid_family                 = yield validate_family(family)
            primary_person               = yield fetch_primary_family_members_person(valid_family)
            secondary_request_params     = yield transform_person_to_secondary_request(primary_person)
            validated_secondary_request  = yield validate_secondary_request(secondary_request_params)
            secondary_request_json       = yield secondary_request_entity_json(validated_secondary_request)

            Success(secondary_request_json)
          end

          private

          # Validate input object
          def validate_family(family)
            if family.is_a?(::AcaEntities::Families::Family)
              Success(family)
            else
              Failure("Invalid Family, given value is not a ::AcaEntities::Families::Family, input_value:#{family}")
            end
          end

          def fetch_primary_family_member(family)
            primary_family_member = family.family_members.detect { |family_member| family_member.is_primary_applicant }
            if primary_family_member
              Success(primary_family_member.person)
            else
              Failure("No Primary Applicant in family members")
            end
          end

          # Transform Person params To SecondaryRequest Contract params
          def transform_person_to_secondary_request(person)
            ::AcaEntities::Fdsh::Transformers::Ridp::PersonToSecondaryRequest.call(person.to_h.to_json) { |record| @transform_result = record }
            Success(@transform_result)
          end

          # Validate SecondaryRequest params against SecondaryRequest Contract
          def validate_secondary_request(params)
            result = ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequestContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          def secondary_request_entity_json(values)
            result = ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequest.new(values.to_h)

            Success(result.to_h.to_json)
          end
        end
      end
    end
  end
end
