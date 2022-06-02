# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Transformers
      module IapTo
        # rubocop:disable Style/Lambda
        # This transformer is used for Transform the data of the MagiMedicaidApplication Contract params
        # to MitcApplication Contract params.
        # This class is PRIVATE and cannot be called from outside except from operation:
        # AcaEntities::MagiMedicaid::Operations::Mitc::GenerateRequestPayload
        # TODO: Remove the mocked attributes
        class Mitc < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'applicants' do
            rewrap 'people', type: :array do
              rewrap '', type: :hash do

                # TODO: Remove below mocked attributes
                add_key 'has_forty_title_ii_work_quarters', value: 'N'
                add_key 'is_amerasian', value: 'N'

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

                map 'is_claimed_as_dependent_by_non_applicant', 'is_claimed_as_dependent_by_non_applicant', function: ->(v) { boolean_string(v) }
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

                map 'mitc_is_required_to_file_taxes', 'is_required_to_file_taxes', function: ->(value) { boolean_string(value) }
                map 'age_of_applicant', 'age_of_applicant'
                map 'hours_worked_per_week', 'hours_worked_per_week'

                map 'is_temporarily_out_of_state', 'is_temporarily_out_of_state', memoize: true, visible: false
                map 'mitc_state_resident', 'mitc_state_resident', memoize: true, visible: false
                map 'is_homeless', 'is_homeless', memoize: true, visible: false
                map 'has_in_state_home_address', 'has_in_state_home_address', memoize: true, visible: false
                add_key 'resides_in_state_of_application', function: ->(v) {
                  mitc_state_resident = boolean_string(v.resolve('mitc_state_resident').item)
                  return mitc_state_resident unless mitc_state_resident.nil?

                  # logic to handle older applications that don't contatain the mitc_state_resident field
                  has_in_state_home_address = v.resolve('has_in_state_home_address').item
                  is_temporarily_out_of_state = v.resolve('is_temporarily_out_of_state').item
                  is_homeless = v.resolve('is_homeless').item
                  resides_in_state = (has_in_state_home_address && !is_temporarily_out_of_state) ||
                                     (has_in_state_home_address && !is_temporarily_out_of_state && is_homeless)
                  boolean_string(resides_in_state)
                }
                add_key 'is_temporarily_out_of_state', function: ->(v) {
                  has_in_state_home_address = v.resolve('has_in_state_home_address').item
                  is_homeless = v.resolve('is_homeless').item
                  is_temporarily_out_of_state = v.resolve('is_temporarily_out_of_state').item
                  resides_in_state = has_in_state_home_address || is_homeless

                  # is_temporarily_out_of_state is used to set 'Claimer Is Out of State' in Mitc Request
                  if resides_in_state
                    # if the applicant resides in state, then is_temporarily_out_of_state can be used
                    boolean_string(is_temporarily_out_of_state)
                  else
                    # if the applicant does not reside in state, this must be set to true for mitc to produce the correct determination
                    boolean_string(true)
                  end
                }

                namespace 'citizenship_immigration_status_information' do
                  rewrap '' do
                    map 'citizen_status', 'citizen_status', memoize: true, visible: false
                    add_key 'is_us_citizen', function: ->(v) { 
                      citizen_status = v.resolve('citizen_status').item
                      us_citizen_kinds = ['us_citizen', 'naturalized_citizen']
                      boolean_string(us_citizen_kinds.include?(citizen_status)) 
                    }

                    # TODO: use mapper to determine the immigration status code from AcaEntities::MagiMedicaid::Mitc::Types::ImmigrationStatusCodeMap
                    # Currently defaulting immigration_status to 01 which maps to 'Lawful Permanent Resident (LPR/Green Card Holder)'
                    add_key 'immigration_status', function: ->(v) {
                      AcaEntities::MagiMedicaid::Mitc::Types::ImmigrationStatusCodeMap[v.resolve('citizen_status').item] || '01'
                    }

                    map 'is_lawful_presence_self_attested', 'is_lawful_presence_self_attested', function: ->(value) { boolean_string(value) }
                  end
                end

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_amerasian', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'has_forty_title_ii_work_quarters', value

                # Five Year Bar Information that we got as part of VLP response payload from FDSH Gateway.
                map 'five_year_bar_applies', 'five_year_bar_applies', function: ->(value) { boolean_string(value) }
                map 'five_year_bar_met', 'is_five_year_bar_met', function: ->(value) { boolean_string(value) }

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
          map 'hbx_id', 'name'

        end
        # rubocop:enable Style/Lambda
      end
    end
  end
end
