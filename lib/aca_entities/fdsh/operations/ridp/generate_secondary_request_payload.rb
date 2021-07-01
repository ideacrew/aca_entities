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
            secondary_request_evidence   = yield fetch_secondary_request_evidence(primary_person)
            secondary_request_json       = yield fetch_secondary_request(secondary_request_evidence)

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
            primary_family_member = family.family_members.detect(&:is_primary_applicant)
            if primary_family_member
              Success(primary_family_member.person)
            else
              Failure("No Primary Applicant in family members")
            end
          end

          def fetch_secondary_request_evidence(primary_person)
            Try do
              primary_person.user.attestations[:ridp_attestation].evidences.detect do |evidence|
                evidence.secondary_request.present?
              end
            end
          end

          def fetch_secondary_request(evidence)
            if evidence.is_a?(::AcaEntities::Evidences::RidpEvidence)
              Success(evidence.secondary_request.to_h.to_json)
            else
              Failure("Invalid Evidence, given value is not a AcaEntities::Evidences::RidpEvidence, input_value:#{evidence}")
            end
          end
        end
      end
    end
  end
end
