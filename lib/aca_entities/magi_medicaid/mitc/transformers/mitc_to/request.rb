# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Mitc
      module Transformers
        module MitcTo
          # This transformer is used for Transform the keys
          class Request < ::AcaEntities::Operations::Transforms::Transform
            include ::AcaEntities::Operations::Transforms::Transformer

            map 'state', 'State'
            map 'application_year', 'Application Year'
            map 'name', 'Name'

            namespace 'people' do
              rewrap 'People', type: :array do
                rewrap '', type: :hash do
                  map 'person_id', 'Person ID'
                  map 'is_applicant', 'Is Applicant'
                  map 'is_blind_or_disabled', 'Applicant Attest Blind or Disabled'
                  map 'is_full_time_student', 'Student Indicator'
                  map 'is_medicare_entitled', 'Medicare Entitlement Indicator'
                  map 'is_incarcerated', 'Incarceration Status'
                  map 'resides_in_state_of_application', 'Lives In State'
                  map 'is_claimed_as_dependent_by_non_applicant', 'Claimed as Dependent by Person Not on Application'
                  map 'is_self_attested_long_term_care', 'Applicant Attest Long Term Care'
                  map 'has_insurance', 'Has Insurance'
                  map 'has_state_health_benefit', 'State Health Benefits Through Public Employee'
                  map 'had_prior_insurance', 'Prior Insurance'
                  # Value Transform to required date string format. Example: 2001-07-01
                  map 'prior_insurance_end_date', 'Prior Insurance End Date'
                  map 'is_pregnant', 'Applicant Pregnant Indicator'
                  map 'children_expected_count', 'Number of Children Expected'
                  map 'is_in_post_partum_period', 'Applicant Post Partum Period Indicator'
                  map 'is_in_former_foster_care', 'Former Foster Care'
                  map 'had_medicaid_during_foster_care', 'Had Medicaid During Foster Care'
                  map 'age_left_foster_care', 'Age Left Foster Care'
                  map 'foster_care_us_state', 'Foster Care State'
                  map 'is_required_to_file_taxes', 'Required to File Taxes'
                  map 'age_of_applicant', 'Applicant Age'
                  map 'hours_worked_per_week', 'Hours Worked Per Week'
                  map 'is_temporarily_out_of_state', 'Claimer Is Out of State'
                  map 'is_us_citizen', 'US Citizen Indicator'
                  map 'is_lawful_presence_self_attested', 'Lawful Presence Attested'
                  map 'immigration_status', 'Immigration Status'
                  map 'is_amerasian', 'Amerasian Immigrant'
                  map 'has_forty_title_ii_work_quarters', 'Applicant Has 40 Title II Work Quarters'
                  map 'five_year_bar_applies', 'Five Year Bar Applies'
                  map 'is_five_year_bar_met', 'Five Year Bar Met'
                  map 'is_trafficking_victim', 'Victim of Trafficking'
                  map 'is_eligible_for_refugee_medical_assistance', 'Refugee Status'
                  # Value Transform to required date string format. Example: 2001-07-01
                  map 'refugee_medical_assistance_start_date', 'Refugee Medical Assistance Start Date'
                  # Value Transform to required date string format. Example: 2001-07-01
                  map 'seven_year_limit_start_date', 'Seven Year Limit Start Date'
                  map 'is_veteran', 'Veteran Status'

                  namespace 'relationships' do
                    rewrap 'Relationships', type: :array do
                      rewrap '' do
                        map 'other_id', 'Other ID'
                        map 'attest_primary_responsibility', 'Attest Primary Responsibility'
                        map 'relationship_code', 'Relationship Code'
                      end
                    end
                  end

                  namespace 'income' do
                    rewrap 'income', type: :hash do
                      # map 'amount', "Wages, Salaries, Tips"
                      # map 'taxable_interest', 'Taxable Interest'
                      # map 'tax_exempt_interest', 'Tax-Exempt Interest'
                      # map 'taxable_refunds', 'Taxable Refunds, Credits, or Offsets of State and Local Income Taxes'
                      map 'alimony', 'Alimony'
                      # map 'capital_gain_or_loss', 'Capital Gain or Loss'
                      # map 'pensions_and_annuities_taxable_amount', 'Pensions and Annuities Taxable Amount'
                      # map 'farm_income_or_loss', 'Farm Income or Loss'
                      # map 'unemployment_compensation', 'Unemployment Compensation'
                      # map 'other_income', 'Other Income'
                      # map 'magi_deductions', 'MAGI Deductions'
                      map 'adjusted_gross_income', 'AGI'
                      # map 'deductible_part_of_self_employment_tax', 'Deductible Part of Self-Employment Tax'
                      # map 'ira_deduction', 'IRA Deduction'
                      # map 'student_loan_interest_deduction', 'Student Loan Interest Deduction'
                      # map 'tution_and_fees', 'Tuition and Fees'
                      # map 'other_magi_eligible_income', 'Other MAGI-Eligible Income'
                    end
                  end

                end
              end
            end

          end
        end
      end
    end
  end
end
