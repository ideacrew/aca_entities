# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::ProductEligibilityDetermination}
      class ProductEligibilityDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_ia_eligible optional
        # @option opts [Boolean] :is_medicaid_chip_eligible optional
        # @option opts [Boolean] :is_non_magi_medicaid_eligible optional
        # @option opts [Boolean] :is_totally_ineligible optional
        # @option opts [Boolean] :is_without_assistance optional
        # @option opts [Boolean] :is_magi_medicaid optional
        # @option opts [Boolean] :is_uqhp_eligible optional
        # @option opts [Boolean] :is_csr_eligible optional
        # @option opts [String] :csr optional
        # @option opts [Float] :magi_medicaid_monthly_household_income optional
        # @option opts [Integer] :medicaid_household_size optional
        # @option opts [Float] :magi_medicaid_monthly_income_limit optional
        # @option opts [Float] :magi_as_percentage_of_fpl optional
        # @option opts [String] :magi_medicaid_category optional
        # @option opts [Array] :magi_medicaid_ineligibility_reasons optional
        # @option opts [Boolean] :is_eligible_for_non_magi_reasons optional
        # @option opts [Array] :chip_ineligibility_reasons optional
        # @option opts [Float] :magi_medicaid_category_threshold optional
        # @option opts [String] :medicaid_chip_category optional
        # @option opts [Float] :medicaid_chip_category_threshold optional
        # @option opts [Array] :category_determinations optional
        # @option opts [Array] :member_determinations optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_ia_eligible).maybe(:bool)
          optional(:is_medicaid_chip_eligible).maybe(:bool)
          optional(:is_totally_ineligible).maybe(:bool)
          optional(:is_magi_medicaid).maybe(:bool)
          optional(:is_uqhp_eligible).maybe(:bool)
          optional(:is_csr_eligible).maybe(:bool)
          optional(:csr).maybe(Types::CsrKind)

          optional(:is_non_magi_medicaid_eligible).maybe(:bool)
          optional(:is_without_assistance).maybe(:bool)

          optional(:magi_medicaid_monthly_household_income).maybe(Types::Money)
          optional(:medicaid_household_size).maybe(:integer)
          optional(:magi_medicaid_monthly_income_limit).maybe(Types::Money)
          optional(:magi_as_percentage_of_fpl).maybe(Types::Money)
          optional(:magi_medicaid_category).maybe(Types::MagiMedicaidCategoryType)

          optional(:magi_medicaid_ineligibility_reasons).array(:string)
          optional(:is_eligible_for_non_magi_reasons).maybe(:bool)
          optional(:chip_ineligibility_reasons).array(:string)
          optional(:magi_medicaid_category_threshold).maybe(Types::Money)
          optional(:medicaid_chip_category).maybe(:string)
          optional(:medicaid_chip_category_threshold).maybe(Types::Money)

          optional(:category_determinations).array(CategoryDeterminationContract.params)
          optional(:member_determinations).array(MemberDeterminationContract.params)
        end
      end
    end
  end
end
