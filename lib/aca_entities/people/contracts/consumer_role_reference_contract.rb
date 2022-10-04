# frozen_string_literal: true

module AcaEntities
  module People
    module Contracts
      # Schema and validation rules for {AcaEntities::People::ConsumerRoleReference}.
      class ConsumerRoleReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_active required
        # @option opts [Boolean] :is_applying_coverage required
        # @option opts [Boolean] :is_applicant required
        # @option opts [Boolean] :is_state_resident required
        # @option opts [Hash] :lawful_presence_determination required
        # @option opts [String] :citizen_status required
        # @return [Dry::Monads::Result]
        params do
          required(:is_active).filled(:bool)
          required(:is_applying_coverage).value(:bool?)
          required(:is_applicant).filled(:bool)
          required(:is_state_resident).filled(:bool)
          required(:lawful_presence_determination).hash(
            AcaEntities::Determinations::Contracts::LawfulPresenceDeterminationContract.params
          )
          required(:citizen_status).filled(:string)
        end
      end
    end
  end
end
