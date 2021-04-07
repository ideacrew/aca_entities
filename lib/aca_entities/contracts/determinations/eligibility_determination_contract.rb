# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Determinations
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
          optional(:e_pdc_id).filled(:string)
          optional(:benchmark_plan).filled(:hash)
          optional(:source).filled(
            AcaEntities::Types::EligibilitySourceKinds
          )
          optional(:premium_credit_strategy_kind).filled(
            AcaEntities::Types::PremiumCreditStrategyKinds
          )
          optional(:csr_eligibility_kind).filled(
            AcaEntities::Types::EligibilityCsrKinds
          )
          optional(:aptc_csr_annual_household_income).maybe(:AcaEntities::Types::Money)
          optional(:aptc_annual_income_limit).maybe(:AcaEntities::Types::Money)
          optional(:csr_annual_income_limit).maybe(:AcaEntities::Types::Money)
          required(:max_aptc).filled(:hash)
          required(:csr_percent_as_integer).filled(:integer)
          required(:determined_at).filled(:date)
        end

        rule(:benchmark_plan) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Products::ProductReferenceContract.new.call(value)
              key.failure(text: "invalid max aptc", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid max aptc. Expected a hash.")
            end
          end
        end

        rule(:max_aptc) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid max aptc", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid max aptc. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
