# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a monetary payment received, usually on a regular basis.
          class HouseholdIncome
            include HappyMapper

            tag 'HouseholdIncome'
            namespace 'hix-ee'

            has_one :income_frequency, IncomeFrequency

            # An amount of money (in dollars) earned
            element :income_amount, Float, tag: 'IncomeAmount', namespace: "hix-core"

            # A number of hours worked per week.
            element :hours_per_week, Float, tag: 'IncomeHoursPerWeekMeasure', namespace: "hix-core"

            # A number of hours worked per pay period.
            element :hours_per_pay_period, Float, tag: 'IncomeHoursPerPayPeriodMeasure', namespace: "hix-core"

            # A number of days worked per week.
            element :days_per_week, Float, tag: 'IncomeDaysPerWeekMeasure', namespace: "hix-core"

            # A kind of income.
            element :income_type_code, String, tag: 'IncomeCategoryCode', namespace: "hix-core"

            has_one :date, IncomeDate
            has_one :source_organization_reference, IncomeSourceOrganizationReference

            # A percent of the federal poverty level that this income represents.
            element :monthly_income_greater_than_fpl, Float, tag: 'IncomeFederalPovertyLevelPercent', namespace: "hix-core"

            # True if an income is from a statutorily excluded American Indian / Alaska Native source
            # (see 42 C.F.R. Section 435.603(e)(3)); false otherwise.
            element :subject_to_federal_restrictions_indicator, Boolean, tag: "IncomeSubjectToFederalRestrictionsIndicator", namespace: "hix-core"

            has_one :payment_frequency, IncomePaymentFrequency
            has_one :earned_date_range, IncomeEarnedDateRange

            # A description of the work for which an income is received (usually referring to self-employment income).
            element :description_text, String, tag: 'IncomeEmploymentDescriptionText', namespace: "hix-core"

            # A description of the source of an income received as unemployment compensation (e.g. the name of a state or employer).
            element :employment_source_text, String, tag: 'IncomeUnemploymentSourceText', namespace: "hix-core"

            def self.domain_to_mapper(h_income)
              mapper = self.new
              mapper.income_amount = h_income.income_amount
              mapper.hours_per_week = h_income.hours_per_week
              mapper.hours_per_pay_period = h_income.hours_per_pay_period
              mapper.days_per_week = h_income.days_per_week
              mapper.income_type_code = h_income.income_type_code
              mapper.monthly_income_greater_than_fpl = h_income.monthly_income_greater_than_fpl
              mapper.subject_to_federal_restrictions_indicator = h_income.subject_to_federal_restrictions_indicator
              mapper.description_text = h_income.description_text
              mapper.employment_source_text = h_income.employment_source_text
              mapper.income_frequency = IncomeFrequency.domain_to_mapper(h_income.income_frequency)
              mapper.date = IncomeDate.domain_to_mapper(h_income.date)
              mapper.source_organization_reference = IncomeSourceOrganizationReference.domain_to_mapper(h_income.source_organization_reference)
              mapper.payment_frequency = IncomePaymentFrequency.domain_to_mapper(h_income.payment_frequency)
              mapper.earned_date_range = IncomeEarnedDateRange.domain_to_mapper(h_income.earned_date_range)
              mapper
            end

            def to_hash
              {
                employment_source_text: employment_source_text,
                income_amount: income_amount,
                days_per_week: days_per_week,
                hours_per_pay_period: hours_per_pay_period,
                hours_per_week: hours_per_week,
                income_type_code: income_type_code,
                description_text: description_text,
                monthly_income_greater_than_fpl: monthly_income_greater_than_fpl,
                subject_to_federal_restrictions_indicator: subject_to_federal_restrictions_indicator,
                date: date&.to_hash,
                earned_date_range: earned_date_range&.to_hash,
                income_frequency: income_frequency&.to_hash,
                payment_frequency: payment_frequency&.to_hash,
                source_organization_reference: source_organization_reference&.to_hash
              }
            end
          end
        end
      end
    end
  end
end