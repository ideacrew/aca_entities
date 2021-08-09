# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a monetary payment received, usually on a regular basis.
          class PersonIncome
            include HappyMapper

            tag 'PersonIncome'
            namespace 'hix-core'

            has_one :frequency, IncomeFrequency

            # An amount of money (in dollars) earned
            element :amount, Float, tag: 'IncomeAmount', namespace: "hix-core"

            # A number of hours worked per week.
            element :hours_per_week, Float, tag: 'IncomeHoursPerWeekMeasure', namespace: "hix-core"

            # A number of hours worked per pay period.
            element :hours_per_pay_period, Float, tag: 'IncomeHoursPerPayPeriodMeasure', namespace: "hix-core"

            # A number of days worked per week.
            element :days_per_week, Float, tag: 'IncomeDaysPerWeekMeasure', namespace: "hix-core"

            # A kind of income.
            element :category_code, String, tag: 'IncomeCategoryCode', namespace: "hix-core"

            has_one :date, IncomeDate
            has_one :source_organization_reference, IncomeSourceOrganizationReference

            # True if an income is from a statutorily excluded American Indian / Alaska Native source
            # (see 42 C.F.R. Section 435.603(e)(3)); false otherwise.
            element :subject_to_federal_restrictions_indicator, Boolean, tag: "IncomeSubjectToFederalRestrictionsIndicator", namespace: "hix-core"

            has_one :payment_frequency, IncomePaymentFrequency
            has_one :earned_date_range, IncomeEarnedDateRange

            # A description of the work for which an income is received (usually referring to self-employment income).
            element :description_text, String, tag: 'IncomeEmploymentDescriptionText', namespace: "hix-core"

            # A description of the source of an income received as unemployment compensation (e.g. the name of a state or employer).
            element :employment_source_text, String, tag: 'IncomeUnemploymentSourceText', namespace: "hix-core"

            def self.domain_to_mapper(income)
              mapper = self.new
              mapper.employment_source_text = income.employment_source_text
              mapper.amount = income.amount
              mapper.days_per_week = income.days_per_week
              mapper.hours_per_pay_period = income.hours_per_pay_period
              mapper.hours_per_week = income.hours_per_week
              mapper.category_code = income.category_code
              mapper.description_text = income.description_text
              mapper.subject_to_federal_restrictions_indicator = income.subject_to_federal_restrictions_indicator
              mapper.date = IncomeDate.domain_to_mapper(income.date)
              mapper.earned_date_range = IncomeEarnedDateRange.domain_to_mapper(income.earned_date_range) if income.earned_date_range
              mapper.frequency = IncomeFrequency.domain_to_mapper(income.frequency)
              mapper.payment_frequency = IncomePaymentFrequency.domain_to_mapper(income&.payment_frequency) if income.payment_frequency
              mapper.source_organization_reference = IncomeSourceOrganizationReference.domain_to_mapper(income.source_organization_reference)
              mapper
            end

            def to_hash
              {
                employment_source_text: employment_source_text,
                amount: amount,
                days_per_week: days_per_week,
                hours_per_pay_period: hours_per_pay_period,
                hours_per_week: hours_per_week,
                category_code: category_code,
                description_text: description_text,
                subject_to_federal_restrictions_indicator: subject_to_federal_restrictions_indicator,
                date: date&.to_hash,
                earned_date_range: earned_date_range&.to_hash,
                frequency: frequency&.to_hash,
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