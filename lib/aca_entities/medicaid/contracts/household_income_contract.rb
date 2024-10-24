# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for HouseholdIncome.
      class HouseholdIncomeContract < Dry::Validation::Contract

        params do
          optional(:monthly_income_greater_than_fpl).maybe(:float)
          optional(:category_code).maybe(:string)
          optional(:amount).maybe(:float)
          optional(:income_frequency).maybe(:hash)
          optional(:income_from_tribal_source).maybe(:float)
          optional(:monthly_attested_medicaid_household_current_income).maybe(:float)
          optional(:annual_total_project_medicaid_household_current_income).maybe(:float)
          optional(:hours_per_week).maybe(:float)
          optional(:hours_per_pay_period).maybe(:float)
          optional(:days_per_week).maybe(:float)
          optional(:date).maybe(:hash)
          optional(:source_organization_reference).maybe(:hash)
          optional(:subject_to_federal_restrictions_indicator).maybe(:bool)
          optional(:payment_frequency).maybe(:hash)
          optional(:earned_date_range).maybe(:hash)
          optional(:description_text).maybe(:string)
          optional(:employment_source_text).maybe(:string)
        end
      end
    end
  end
end