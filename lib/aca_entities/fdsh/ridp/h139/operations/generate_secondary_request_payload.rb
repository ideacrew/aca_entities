# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Ridp
      module Operations
        # This class takes AcaEntities::Families::Famlily as input and returns the ridp secondary request hash.
        class GenerateSecondaryRequestPayload
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to generate Ridp secondary Request Payload
          # @return [Dry::Monads::Result]
          def call(person)
            _valid_person              = yield validate_person(person)
            secondary_request_evidence = yield fetch_secondary_request_evidence(primary_person)
            secondary_request_json     = yield fetch_secondary_request(secondary_request_evidence)

            Success(secondary_request_json)
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
