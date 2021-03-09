# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for HouseholdIncome.
    class HouseholdIncomeContract < Dry::Validation::Contract

      params do
        optional(:monthly_income_greater_than_fpl).maybe(:bool)
        optional(:income_type).maybe(Iap::Types::IncomeType)
        optional(:income_amount).maybe(:float)
        optional(:income_frequency).maybe(Iap::Types::IncomeFrequency)
        optional(:income_from_tribal_source).maybe(:float)
        optional(:monthly_attested_medicaid_household_current_income).maybe(:float)
        optional(:annual_total_project_medicaid_household_current_income).maybe(:float)
      end

    end
  end
end
