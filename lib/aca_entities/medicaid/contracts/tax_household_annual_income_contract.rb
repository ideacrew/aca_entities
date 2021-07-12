# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for TaxHouseholdAnnualIncome
      class TaxHouseholdAnnualIncomeContract < Dry::Validation::Contract

        params do
          optional(:annual_tax_household_income).maybe(:float)
          optional(:tax_household_size).maybe(:integer)
          optional(:computed_fpl).maybe(:float)
          optional(:annual_income_discrepancy_answer_indicator).maybe(:bool)
          optional(:annual_income_discrepancy_reason).maybe(:bool)
        end
      end
    end
  end
end