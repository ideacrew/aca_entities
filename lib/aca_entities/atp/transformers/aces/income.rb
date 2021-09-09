# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Income < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          IncomeTypes = {
            'wages_and_salaries' => 'Wages',
            'net_self_employment' => 'SelfEmployment',
            'unemployment_income' => 'Unemployment',
            'alimony_and_maintenance' => 'Alimony',
            'capital_gains' => 'CapitalGains',
            'Dividends' => 'dividend',
            'Interest' => 'Interest',
            'pension_retirement_benefits' => 'Pension',
            # 'pension_retirement_benefits' => 'Retirement',
            'rental_and_royalty' => 'RentalOrRoyalty',
            'social_security_benefit' => 'SocialSecurity',
            'american_indian_and_alaskan_native' => 'American Indian/Alaska Native income',
            'employer_funded_disability' => 'Employer-funded disability payments',
            'estate_trust' => 'Unspecified',
            'farming_and_fishing' => 'FarmingOrFishing',
            'foreign' => 'foreign',
            # 'other' => 'Other taxable income',
            'other' => 'Unspecified',
            'INVESTMENT_INCOME' => 'INVESTMENT_INCOME',
            'prizes_and_awards' => 'Winnings',
            # 'scholorship_payments' => 'Taxable scholarship payments',
            'scholorship_payments' => 'Scholarship'
          }.freeze

          add_key 'employment_source_text'
          map 'amount', 'amount'
          add_key 'days_per_week'
          add_key 'hours_per_pay_period', value: ->(_v) {0.0} # default value
          map 'hours_per_week', 'hours_per_week'
          map 'kind', 'category_code', function: lambda { |v|
            IncomeTypes[v]
          }
          add_key 'description_text'
          add_key 'subject_to_federal_restrictions_indicator'
          add_key 'date', value: lambda { |_v|
                                   {
                                     date: Date.today
                                   }
                                 } # default
          map 'end_on', 'earned_date_range.end_date.date', function: ->(_v) { Date.today } # default
          map 'start_on', 'earned_date_range.start_date.date', function: ->(_v) { Date.today } # default

          map 'frequency_kind', 'frequency.frequency_code'
          add_key 'payment_frequency'
          map 'employer.employer_id', 'source_organization_reference.ref'
        end
      end
    end
  end
end