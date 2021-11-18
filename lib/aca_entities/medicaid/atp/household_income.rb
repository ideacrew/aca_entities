# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for HouseholdIncome
      class HouseholdIncome < Dry::Struct
        attribute :monthly_income_greater_than_fpl,                         Types::Float.optional.meta(omittable: true)
        attribute :income_type_code,                                        Types::IncomeCategoryCode.optional.meta(omittable: true)
        attribute :amount,                                                  Types::Float.optional.meta(omittable: true)
        attribute :income_frequency,                                        IncomeFrequency.optional.meta(omittable: true)
        attribute :income_from_tribal_source,                               Types::Float.optional.meta(omittable: true)
        attribute :monthly_attested_medicaid_household_current_income,      Types::Float.optional.meta(omittable: true)
        attribute :annual_total_project_medicaid_household_current_income,  Types::Float.optional.meta(omittable: true)
        attribute :hours_per_week,                                          Types::Float.optional.meta(omittable: true)
        attribute :hours_per_pay_period,                                    Types::Float.optional.meta(omittable: true)
        attribute :days_per_week,                                           Types::Float.optional.meta(omittable: true)
        attribute :date,                                                    IncomeDate.optional.meta(omittable: true)
        attribute :source_organization_reference,                           IncomeSourceOrganizationReference.optional.meta(omittable: true)
        attribute :subject_to_federal_restrictions_indicator,               Types::Bool.optional.meta(omittable: true)
        attribute :payment_frequency,                                       IncomePaymentFrequency.optional.meta(omittable: true)
        attribute :earned_date_range,                                       IncomeEarnedDateRange.optional.meta(omittable: true)
        attribute :description_text,                                        Types::String.optional.meta(omittable: true)
        attribute :employment_source_text,                                  Types::String.optional.meta(omittable: true)
      end
    end
  end
end