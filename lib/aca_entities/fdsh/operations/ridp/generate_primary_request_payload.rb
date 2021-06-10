# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Operations
      module Ridp
        # This class takes AcaEntities::Families::Famlily as input and returns the ridp primary request hash.
        class GeneratePrimaryRequestPayload
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Ridp Primary Request Payload
          # @return [Dry::Monads::Result]
          def call(family)
            valid_family               = yield validate_family(family)
            primary_person             = yield fetch_primary_family_members_person(valid_family)
            primary_request_params     = yield transform_person_to_primary_request(primary_person)
            validated_primary_request  = yield validate_primary_request(primary_request_params)
            primary_request_json       = yield primary_request_entity_json(validated_primary_request)

            Success(primary_request_json)
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

          # Transform Person params To PrimaryRequest Contract params
          def transform_person_to_primary_request(person)
            ::AcaEntities::Fdsh::Transformers::Ridp::PersonToPrimaryRequest.call(person.to_h.to_json) { |record| @transform_result = record }
            Success(@transform_result)
          end

          # Validate PrimaryRequest params against PrimaryRequest Contract
          def validate_primary_request(params)
            result = ::AcaEntities::Fdsh::Ridp::H139::PrimaryRequestContract.new.call(params)

            if result.success?
              Success(result.to_h)
            else
              Failure(result)
            end
          end

          def primary_request_entity_json(values)
            result = ::AcaEntities::Fdsh::Ridp::H139::PrimaryRequest.new(values.to_h)

            Success(result.to_h.to_json)
          end
        end
      end
    end
  end
end
