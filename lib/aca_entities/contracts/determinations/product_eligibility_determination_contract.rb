# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Determinations
      # # Schema and validation rules for {AcaEntities::Determinations::ProductEligibilityDetermination}
      class ProductEligibilityDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_ia_eligible optional
        # @option opts [Boolean] :is_medicaid_chip_eligible optional
        # @option opts [Boolean] :is_non_magi_medicaid_eligible optional
        # @option opts [Boolean] :is_totally_ineligible optional
        # @option opts [Boolean] :is_without_assistance optional
        # @option opts [Hash] :magi_medicaid_monthly_household_income optional
        # @option opts [Integer] :medicaid_household_size optional
        # @option opts [Hash] :magi_medicaid_monthly_income_limit optional
        # @option opts [Float] :magi_as_percentage_of_fpl optional
        # @option opts [String] :magi_medicaid_category optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_ia_eligible).value(:bool?)
          optional(:is_medicaid_chip_eligible).value(:bool?)
          optional(:is_non_magi_medicaid_eligible).value(:bool?)
          optional(:is_totally_ineligible).value(:bool?)
          optional(:is_without_assistance).value(:bool?)
          optional(:is_magi_medicaid).value(:bool?)
          optional(:magi_medicaid_monthly_household_income).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:medicaid_household_size).maybe(:integer)
          optional(:magi_medicaid_monthly_income_limit).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:magi_as_percentage_of_fpl).maybe(:float)
          optional(:magi_medicaid_category).maybe(MagiMedicaid::Types::MagiMedicaidCategoryType)
        end
      end
    end
  end
end
