# frozen_string_literal: true

module AcaEntities
  module People
    module Contracts
      # Schema and validation rules for {AcaEntities::People::ResidentRoleReference}
      class ResidentRoleReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :is_applicant required
        # @option opts [String] :is_active optional
        # @option opts [String] :is_state_resident required
        # @option opts [String] :residency_determined_at optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_applicant).value(:bool?)
          optional(:is_active).maybe(:bool)
          required(:is_state_resident).value(:bool?)
          optional(:residency_determined_at).value(:date)
        end
      end
    end
  end
end
