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
            # 'Dividends' => 'dividend',
            'dividend' => 'Unspecified',
            'interest' => 'Interest',
            'pension_retirement_benefits' => 'Pension',
            # 'pension_retirement_benefits' => 'Retirement',
            'rental_and_royalty' => 'RentalOrRoyalty',
            'social_security_benefit' => 'SocialSecurity',
            'american_indian_and_alaskan_native' => 'Unspecified',
            'employer_funded_disability' => 'Unspecified',
            'estate_trust' => 'Unspecified',
            'farming_and_fishing' => 'FarmingOrFishing',
            'foreign' => 'Unspecified',
            # 'other' => 'Other taxable income',
            'other' => 'Unspecified',
            'INVESTMENT_INCOME' => 'INVESTMENT_INCOME',
            'prizes_and_awards' => 'Winnings',
            # 'scholorship_payments' => 'Taxable scholarship payments',

            'scholarship_payments' => 'Scholarship'
          }.freeze

          map 'amount', 'amount'
          add_key 'days_per_week', value: lambda { |v|
                                            frequency = v.resolve('frequency.frequency_code').item
                                            if frequency == "Daily"
                                              0 # default
                                            end
                                          }
          # add_key 'hours_per_pay_period', value: ->(_v) {0.0} # default value only required if Date tag is used
          # map 'hours_per_week', 'hours_per_week'
          map 'kind', 'category_code', memoize: true, function: lambda { |v|
            IncomeTypes[v]
          }
          add_key 'employment_source_text', value: lambda { |v|
                                                     category_code = v.resolve("category_code").item
                                                     if category_code == "unemployment_income"
                                                       "unemployment" # default
                                                     end
                                                   }

          add_key 'description_text', value: lambda { |v|
                                               category_code = v.resolve("category_code").item
                                               if category_code == "net_self_employment"
                                                 "self employed" # default
                                               end
                                             }

          add_key 'subject_to_federal_restrictions_indicator'

          map 'end_on', 'end_on', memoize: true, visible: false

          # add_key 'date', function: lambda { |v|
          #                             end_on = v.resolve("end_on").item
          #                             frequency = v.resolve("frequency.frequency_code").item
          #                             unless end_on.nil?
          #                               income_date = { year: Date.parse(end_on).year.to_s } if frequency == "Annually"
          #                               income_date = { year_month: DateTime.parse("2021-01-01").strftime("%Y-%m").to_s } if frequency == "Monthly"
          #                             end
          #                             income_date
          #                           }

          # Date range tags not mapped due to ACES ingestion issues
          # map 'end_on', 'earned_date_range.end_date.date', function: ->(v) { Date.parse(v) unless v.nil? }
          # map 'start_on', 'earned_date_range.start_date.date', function: ->(v) { Date.parse(v) unless v.nil? }

          map 'frequency_kind', 'frequency.frequency_code', memoize: true
          add_key 'payment_frequency.frequency_code', function: ->(v) { v.resolve('frequency.frequency_code').item }
          map 'employer.employer_id', 'source_organization_reference.ref'
        end
      end
    end
  end
end