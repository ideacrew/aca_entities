# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Transformers
      module IapTo
        # rubocop:disable Style/Lambda
        class Mitc < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'applicants' do
            rewrap 'people', type: :array do
              rewrap '', type: :hash do

                namespace 'mitc_relationships' do
                  rewrap 'relationships', type: :array do
                    rewrap '' do
                      map 'other_id', 'other_id'
                      map 'attest_primary_responsibility', 'attest_primary_responsibility'
                      map 'relationship_code', 'relationship_code'
                    end
                  end
                end

                namespace 'mitc_income' do
                  rewrap 'income', type: :hash do
                    map 'amount', 'amount'
                    map 'taxable_interest', 'taxable_interest'
                    map 'tax_exempt_interest', 'tax_exempt_interest'
                    map 'taxable_refunds', 'taxable_refunds'
                    map 'alimony', 'alimony'
                    map 'capital_gain_or_loss', 'capital_gain_or_loss'
                    map 'pensions_and_annuities_taxable_amount', 'pensions_and_annuities_taxable_amount'
                    map 'farm_income_or_loss', 'farm_income_or_loss'
                    map 'unemployment_compensation', 'unemployment_compensation'
                    map 'other_income', 'other_income'
                    map 'magi_deductions', 'magi_deductions'
                    map 'adjusted_gross_income', 'adjusted_gross_income'
                    map 'deductible_part_of_self_employment_tax', 'deductible_part_of_self_employment_tax'
                    map 'ira_deduction', 'ira_deduction'
                    map 'student_loan_interest_deduction', 'student_loan_interest_deduction'
                    map 'tution_and_fees', 'tution_and_fees'
                    map 'other_magi_eligible_income', 'other_magi_eligible_income'
                  end
                end

                namespace 'family_member_reference' do
                  rewrap '' do
                    map 'person_hbx_id', 'person_id'
                  end
                end

                map 'is_applying_coverage', 'is_applicant', function: ->(value) { boolean_string(value) }

                namespace 'student' do
                  rewrap '' do
                    map 'is_student', 'is_full_time_student', function: ->(value) { boolean_string(value) }
                  end
                end

                map 'is_medicare_eligible', 'is_medicare_entitled', function: ->(value) { boolean_string(value) }

                namespace 'attestation' do
                  rewrap '' do
                    map 'is_self_attested_blind', 'is_self_attested_blind', memoize: true, visible: false
                    map 'is_self_attested_disabled', 'is_self_attested_disabled', memoize: true, visible: false
                    add_key 'is_blind_or_disabled', function: ->(v) {
                      boolean_string(v.resolve('is_self_attested_blind').item || v.resolve('is_self_attested_disabled').item)
                    }
                    map 'is_incarcerated', 'is_incarcerated', function: ->(value) { boolean_string(value) }
                  end
                end

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_claimed_as_dependent_by_non_applicant', value

                map 'is_self_attested_long_term_care', 'is_self_attested_long_term_care', function: ->(value) { boolean_string(value) }
                map 'has_insurance', 'has_insurance', function: ->(value) { boolean_string(value) }
                map 'has_state_health_benefit', 'has_state_health_benefit', function: ->(value) { boolean_string(value) }
                map 'had_prior_insurance', 'had_prior_insurance', function: ->(value) { boolean_string(value) }
                map 'prior_insurance_end_date', 'prior_insurance_end_date'

                namespace 'pregnancy_information' do
                  rewrap '' do
                    map 'is_pregnant', 'is_pregnant', function: ->(value) { boolean_string(value) }
                    map 'expected_children_count', 'children_expected_count'

                    map 'is_post_partum_period', 'is_in_post_partum_period', function: ->(value) { boolean_string(value) }
                  end
                end

                namespace 'foster_care' do
                  rewrap '' do
                    map 'is_former_foster_care', 'is_in_former_foster_care', function: ->(value) { boolean_string(value) }
                    map 'had_medicaid_during_foster_care', 'had_medicaid_during_foster_care', function: ->(value) { boolean_string(value) }
                    map 'age_left_foster_care', 'age_left_foster_care'
                    map 'foster_care_us_state', 'foster_care_us_state'
                  end
                end

                map 'is_required_to_file_taxes', 'is_required_to_file_taxes', function: ->(value) { boolean_string(value) }
                map 'age_of_applicant', 'age_of_applicant'
                map 'hours_worked_per_week', 'hours_worked_per_week'

                map 'is_temporarily_out_of_state', 'is_temporarily_out_of_state', memoize: true, visible: false
                add_key 'resides_in_state_of_application', function: ->(v) {
                  boolean_string(v.resolve('is_temporarily_out_of_state').item)
                }
                add_key 'is_temporarily_out_of_state', function: ->(v) {
                  boolean_string(v.resolve('is_temporarily_out_of_state').item)
                }

                # map 'is_temporarily_out_of_state', 'is_temporarily_out_of_state', function: ->(value) { boolean_string(value) }
                # map 'resides_in_state_of_application', 'is_required_to_file_taxes', function: ->(value) { boolean_string(value) }

                # map 'is_temporarily_out_of_state', 'out_of_state', context: { name: 'out_of_state' }, visible: false
                # add_key 'resides_in_state_of_application', function: ->(v) { boolean_string(v.resolve('out_of_state').item) }
                # add_key 'is_temporarily_out_of_state', function: ->(v) { boolean_string(v.resolve('out_of_state').item) }

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_lawful_presence_self_attested', value

                namespace 'citizenship_immigration_status_information' do
                  rewrap '' do
                    map 'citizen_status', 'citizen_status', memoize: true, visible: false
                    add_key 'is_us_citizen', function: ->(v) { boolean_string(v.resolve('citizen_status').item == 'us_citizen') }

                    # TODO: use mapper to determine the immigration status code from AcaEntities::MagiMedicaid::Mitc::Types::ImmigrationStatusCodeMap
                    add_key 'immigration_status', function: ->(v) {
                      AcaEntities::MagiMedicaid::Mitc::Types::ImmigrationStatusCodeMap[v.resolve('citizen_status').item] || '99'
                    }

                    map 'is_lawful_presence_self_attested', 'is_lawful_presence_self_attested', function: ->(value) { boolean_string(value) }
                  end
                end

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_amerasian', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'has_forty_title_ii_work_quarters', value

                map 'is_subject_to_five_year_bar', 'five_year_bar_applies', function: ->(value) { boolean_string(value) }
                map 'is_five_year_bar_met', 'is_five_year_bar_met', function: ->(value) { boolean_string(value) }
                map 'is_trafficking_victim', 'is_trafficking_victim', function: ->(value) { boolean_string(value) }
                map 'is_refugee', 'is_eligible_for_refugee_medical_assistance', function: ->(value) { boolean_string(value) }

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'refugee_medical_assistance_start_date', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'seven_year_limit_start_date', value

                namespace 'demographic' do
                  rewrap '' do
                    map 'is_veteran_or_active_military', 'is_veteran', function: ->(value) { boolean_string(value) }
                  end
                end
              end
            end
          end

          # map 'mitc_households', 'physical_households', memoize_record: true
          # add_key 'physical_households', function: ->(v) { v.resolve('physical_households').item }

          namespace 'mitc_households' do
            rewrap 'physical_households', type: :array do
              rewrap '' do
                map 'household_id', 'household_id'

                namespace 'people' do
                  rewrap 'people', type: :array do
                    rewrap '' do
                      map 'person_id', 'person_id'
                    end
                  end
                end
              end
            end
          end

          namespace 'mitc_tax_returns' do
            rewrap 'tax_returns', type: :array do
              rewrap '' do

                namespace 'filers' do
                  rewrap 'filers', type: :array do
                    rewrap '' do
                      map 'person_id', 'person_id'
                    end
                  end
                end

                namespace 'dependents' do
                  rewrap 'dependents', type: :array do
                    rewrap '' do
                      map 'person_id', 'person_id'
                    end
                  end
                end
              end
            end
          end

          map 'assistance_year', 'application_year'
          map 'us_state', 'state'

        end
        # rubocop:enable Style/Lambda
      end
    end
  end
end
