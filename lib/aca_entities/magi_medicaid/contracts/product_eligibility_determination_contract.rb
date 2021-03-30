# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for ProductEligibilityDetermination
      class ProductEligibilityDeterminationContract < Dry::Validation::Contract

        params do
          optional(:is_ia_eligible).maybe(:bool)
          optional(:is_medicaid_chip_eligible).maybe(:bool)
          optional(:is_non_magi_medicaid_eligible).maybe(:bool)
          optional(:is_totally_ineligible).maybe(:bool)
          optional(:is_without_assistance).maybe(:bool)
          optional(:is_magi_medicaid).maybe(:bool)
          optional(:magi_medicaid_monthly_household_income).maybe(:float)
          optional(:medicaid_household_size).maybe(:integer)
          optional(:magi_medicaid_monthly_income_limit).maybe(:float)
          optional(:magi_as_percentage_of_fpl).maybe(:float)
          optional(:magi_medicaid_category).maybe(Types::MagiMedicaidCategoryType)
        end
      end
    end
  end
end
