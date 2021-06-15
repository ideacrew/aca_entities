# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a monetary payment received, usually on a regular basis.
          class PersonIncome
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'PersonIncome'
            namespace 'hix-core'

            # A description of the source of an income received as unemployment compensation (e.g. the name of a state or employer).
            element :employment_source_text, String, tag: 'IncomeUnemploymentSourceText', namespace: "hix-core"

            # An amount of money (in dollars) earned
            element :amount, Float, tag: 'IncomeAmount', namespace: "hix-core"

            # A number of days worked per week.
            element :days_per_week, Float, tag: 'IncomeDaysPerWeekMeasure', namespace: "hix-core"

            # A number of hours worked per pay period.
            element :hours_per_pay_period, Float, tag: 'IncomeHoursPerPayPeriodMeasure', namespace: "hix-core"

            # A number of hours worked per week.
            element :hours_per_week, Float, tag: 'IncomeHoursPerWeekMeasure', namespace: "hix-core"

            # A kind of income.
            element :category_code, String, tag: 'IncomeCategoryCode', namespace: "hix-core"

            # A description of the work for which an income is received (usually referring to self-employment income).
            element :description_text, String, tag: 'IncomeEmploymentDescriptionText', namespace: "hix-core"

            #True if an income is from a statutorily excluded American Indian / Alaska Native source 
            # (see 42 C.F.R. Section 435.603(e)(3)); false otherwise.
            element :subject_to_federal_restrictions_indicator, Boolean, tag: "IncomeSubjectToFederalRestrictionsIndicator", namespace: "hix-core"

            has_one :date, IncomeDate
            has_one :earned_date_range, IncomeEarnedDateRange
            has_one :frequency, IncomeFrequency
            has_one :payment_frequency, IncomePaymentFrequency
            has_one :source_organization_reference, IncomeSourceOrganizationReference


            def self.domain_to_mapper(person)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end