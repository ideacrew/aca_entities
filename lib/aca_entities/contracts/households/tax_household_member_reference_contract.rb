# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHouseholdMemberReference}
      class TaxHouseholdMemberReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_subscriber required
        # @option opts [String] :reason optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_subscriber).filled(:bool)
          optional(:reason).maybe(:string)
        end
      end
    end
  end
end
