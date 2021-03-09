# frozen_string_literal: true

module AcaEntities
  # Entity for HouseholdIncome
  class HouseholdIncome < Dry::Struct
    attribute :monthly_income_greater_than_fpl,                         Types::Bool.optional.meta(omittable: true)
    attribute :income_type_code,                                        Types::String.optional.meta(omittable: true)
    attribute :income_amount,                                           Types::Float.optional.meta(omittable: true)
    attribute :income_frequency,                                        Types::String.optional.meta(omittable: true)
    attribute :income_from_tribal_source,                               Types::Float.optional.meta(omittable: true)
    attribute :monthly_attested_medicaid_household_current_income,      Types::Float.optional.meta(omittable: true)
    attribute :annual_total_project_medicaid_household_current_income,  Types::Float.optional.meta(omittable: true)
  end
end
