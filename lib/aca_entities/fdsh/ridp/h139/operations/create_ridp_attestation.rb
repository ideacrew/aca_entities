# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Operations
      module Ridp
        # This class takes happy mapper hash as input and returns
        class CreateRidpAttestation
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to process
          # @return [Dry::Monads::Result]
          def call(_response)
            params    = yield construct_attestation_params(primary_response)
            values    = yield validate(params)
            entity    = yield create(values)

            Success(entity)
          end

          private

          def construct_attestation_params(response)
            {
              is_satisfied?: primary_response.FinalDecisionCode == 'ACC',
              is_self_attested?: true,
              satisfied_at: DateTime.now,
              evidences: create_evidence(response),
              status: 'in_progress'
            }
          end

          def create_evidence(response)
            input_hash = case response
                         when is_a?(AcaEntities::Fdsh::Ridp::H139::Primaryesponse)
                           { primary_request: response }
                         when is_a?(AcaEntities::Fdsh::Ridp::H139::SecondaryResponse)
                           { secondary_response: response }
                         end
            [AcaEntities::Evidences::RidpEvidence.new(input_hash)]
          end

          def validate(params)
            result = AcaEntities::Attestations::RidpAttestationContract.new.call(params)

            if result.success?
              Success(result)
            else
              Failure("Invalid response, #{result.errors}")
            end
          end

          def create(value)
            Success(AcaEntities::Attestations::RidpAttestation.new(value.to_h))
          end
        end
      end
    end
  end
end
