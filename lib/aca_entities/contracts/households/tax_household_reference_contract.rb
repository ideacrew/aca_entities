# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHouseholdReference}
      class TaxHouseholdReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :max_aptc required
        # @option opts [Hash] :monthly_expected_contribution optional
        # @return [Dry::Monads::Result]
        params do
          required(:max_aptc).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:monthly_expected_contribution).hash(AcaEntities::Contracts::CurrencyContract.params)
        end
      end
    end
  end
end
