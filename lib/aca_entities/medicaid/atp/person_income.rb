# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonIncome
      class PersonIncome < Dry::Struct

        attribute :employment_source_text, Types::String.optional.meta(omittable: true)
        attribute :amount, Types::Float.optional.meta(omittable: true)
        attribute :days_per_week, Types::Integer.optional.meta(omittable: true)
        attribute :hours_per_pay_period, Types::Float.optional.meta(omittable: true)
        attribute :hours_per_week, Types::Float.optional.meta(omittable: true)
        attribute :category_code, Types::String.optional.meta(omittable: true)
        attribute :description_text, Types::String.optional.meta(omittable: true)
        attribute :subject_to_federal_restrictions_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :date, IncomeDate.optional.meta(omittable: true)
        attribute :earned_date_range, IncomeEarnedDateRange.optional.meta(omittable: true)
        attribute :frequency, IncomeFrequency.optional.meta(omittable: true)
        attribute :payment_frequency, IncomePaymentFrequency.optional.meta(omittable: true)
        attribute :source_organization_reference, IncomeSourceOrganizationReference.optional.meta(omittable: true)
      end
    end
  end
end