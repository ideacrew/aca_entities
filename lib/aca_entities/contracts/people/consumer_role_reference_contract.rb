# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
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
          required(:is_applying_coverage).filled(:bool)
          required(:is_applicant).filled(:bool)
          required(:is_state_resident).filled(:bool)
          required(:lawful_presence_determination).filled(:hash)
          required(:citizen_status).filled(:string)
        end

        rule(:lawful_presence_determination) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Determinations::LawfulPresenceDeterminationContract.new.call(value)
              key.failure(text: "invalid lawful_presence_determination.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid lawful_presence_determination. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
