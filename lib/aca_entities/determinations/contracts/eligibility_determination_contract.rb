# frozen_string_literal: true

module AcaEntities
  module Determinations
    module Contracts
      # Schema and validation rules for {AcaEntities::Determinations::EligibilityDetermination}
      class EligibilityDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :e_pdc_id required
        # @option opts [Hash] :benchmark_plan optional
        # @option opts [String] :source required
        # @option opts [String] :premium_credit_strategy_kind required
        # @option opts [String] :csr_eligibility_kind optional
        # @option opts [Money] :aptc_csr_annual_household_income optional
        # @option opts [Money] :aptc_annual_income_limit optional
        # @option opts [Money] :csr_annual_income_limit optional
        # @option opts [Hash] :max_aptc optional
        # @option opts [Integer] :csr_percent_as_integer optional
        # @option opts [Date] :determined_at optional
        # @return [Dry::Monads::Result]
        params do
          optional(:e_pdc_id).maybe(:string) # TODO: verify
          optional(:benchmark_plan).hash(AcaEntities::Products::Contracts::ProductReferenceContract.params)
          optional(:source).maybe(AcaEntities::Types::EligibilitySourceKinds)
          optional(:premium_credit_strategy_kind).maybe(AcaEntities::Types::PremiumCreditStrategyKinds)
          optional(:csr_eligibility_kind).maybe(AcaEntities::Types::EligibilityCsrKinds)
          optional(:aptc_csr_annual_household_income).maybe(AcaEntities::Contracts::CurrencyContract.params)
          optional(:aptc_annual_income_limit).maybe(AcaEntities::Contracts::CurrencyContract.params)
          optional(:csr_annual_income_limit).maybe(AcaEntities::Contracts::CurrencyContract.params)
          required(:max_aptc).filled(AcaEntities::Contracts::CurrencyContract.params)
          required(:csr_percent_as_integer).filled(:integer)
          required(:determined_at).filled(:date)
        end
      end
    end
  end
end
