# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Transformers
      module IapTo
        class Mitc < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'applicants' do
            rewrap 'people', type: :array do
              rewrap '', type: :hash do
                namespace 'family_member_reference' do
                  rewrap '' do
                    map 'person_hbx_id', 'person_id'
                  end
                end

                add_key 'is_applicant', 'Y'

                namespace 'student' do
                  rewrap '' do
                    map 'is_student', 'is_full_time_student', ->(value) { boolean_string(value) }
                  end
                end

                map 'is_medicare_eligible', 'is_medicare_entitled', ->(value) { boolean_string(value) }

                namespace 'attestation' do
                  rewrap '' do
                    # map 'is_self_attested_blind', 'attestation.is_self_attested_blind', { memoize: true }
                    # map 'is_self_attested_disabled', 'attestation.is_self_attested_disabled', { memoize: true }
                    # add_key 'is_blind_or_disabled', ->(v) { v.resolve('attestation.is_self_attested_blind').item ||
                    #                                         v.resolve('attestation.is_self_attested_disabled').item }

                    # value should be (applicant.attestation.is_self_attested_blind || applicant.attestation.is_self_attested_disabled)
                    # add_key 'is_blind_or_disabled', ('is_self_attested_blind' || 'is_self_attested_disabled')

                    map 'is_incarcerated', 'is_incarcerated', ->(value) { boolean_string(value) }
                  end
                end

                # addressess = [
                #   { lives_outside_state_temporarily: true, kind: 'home' },
                #   { lives_outside_state_temporarily: false, kind: 'mailing' }
                # ]

                # map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant',
                #   { memoize: true, function: AcaEntities::Functions::PrimaryApplicantBuilder }

                # value should be one of addressess lives_outside_state_temporarily
                # add_key 'resides_in_state_of_application', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_claimed_as_dependent_by_non_applicant', value

                map 'is_self_attested_long_term_care', 'is_self_attested_long_term_care', ->(value) { boolean_string(value) }
                map 'has_insurance', 'has_insurance', ->(value) { boolean_string(value) }
                map 'has_state_health_benefit', 'has_state_health_benefit', ->(value) { boolean_string(value) }
                map 'had_prior_insurance', 'had_prior_insurance', ->(value) { boolean_string(value) }
                map 'prior_insurance_end_date', 'prior_insurance_end_date'

                namespace 'pregnancy_information' do
                  rewrap '' do
                    map 'is_pregnant', 'is_pregnant', ->(value) { boolean_string(value) }
                    map 'expected_children_count', 'children_expected_count'

                    map 'is_post_partum_period', 'is_in_post_partum_period', ->(value) { boolean_string(value) }
                  end
                end

                namespace 'foster_care' do
                  rewrap '' do
                    map 'is_former_foster_care', 'is_in_former_foster_care', ->(value) { boolean_string(value) }
                    map 'had_medicaid_during_foster_care', 'had_medicaid_during_foster_care', ->(value) { boolean_string(value) }
                    map 'age_left_foster_care', 'age_left_foster_care', ->(value) { boolean_string(value) }
                    map 'foster_care_us_state', 'foster_care_us_state'
                  end
                end

                map 'is_required_to_file_taxes', 'is_required_to_file_taxes', ->(value) { boolean_string(value) }
                map 'age_of_applicant', 'age_of_applicant'
                map 'hours_worked_per_week', 'hours_worked_per_week'

                # value should be one of addresses's lives_outside_state_temporarily
                # add_key 'is_temporarily_out_of_state', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_lawful_presence_self_attested', value

                namespace 'citizenship_immigration_status_information' do
                  rewrap '' do

                    # map 'citizen_status', 'citizenship_immigration_status_information.citizen_status', { memoize: true }
                    # add_key 'is_us_citizen', ->(v) { (v.resolve('citizenship_immigration_status_information.citizen_status').item == 'us_citizen') ? 'Y' : 'N' }

                    # value is citizenship_immigration_status_information.citizen_status == 'us_citizen'
                    # add_key 'is_us_citizen', value

                    map 'citizen_status', 'immigration_status'
                  end
                end

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'is_amerasian', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'has_forty_title_ii_work_quarters', value

                map 'is_subject_to_five_year_bar', 'five_year_bar_applies', ->(value) { boolean_string(value) }
                map 'is_five_year_bar_met', 'is_five_year_bar_met', ->(value) { boolean_string(value) }
                map 'is_trafficking_victim', 'is_trafficking_victim', ->(value) { boolean_string(value) }
                map 'is_refugee', 'is_eligible_for_refugee_medical_assistance', ->(value) { boolean_string(value) }

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'refugee_medical_assistance_start_date', value

                # value should be the new attributes, currently this is not mapped to anything.
                # add_key 'seven_year_limit_start_date', value

                namespace 'demographic' do
                  rewrap '' do
                    map 'is_veteran_or_active_military', 'is_veteran', ->(value) { boolean_string(value) }
                  end
                end
              end
            end

            # ExpectedOutcome:
            # physical_households = [
            #   {
            #     household_id: '1',
            #     people: [
            #       { person_id: 'applicant.family_member_reference.person_hbx_id' },
            #       { person_id: 'applicant2.family_member_reference.person_hbx_id' },
            #     ]
            #   }
            # ]

            # add_key 'physical_households', []
            # namespace 'physical_households', type: :array do
            #   rewrap '', type: :hash do
            #   end
            # end

            # add_namespace 'physical_households', 'physical_households', type: :array do
            #   rewrap '', type: :hash do
            #     add_key 'household_id', '1'
            #     add_key 'people', ->(v) { v.resolve(:'applicant.family_member_reference.person_references') }
            #     # add_namespace 'people', 'physical_households.people', type: :array do
            #     #   rewrap '', type: :hash do
            #     #     add_key 'person_id', value
            #     #   end
            #     # end
            #   end
            # end
          end

          map 'assistance_year', 'application_year'
          map 'us_state', 'state'

        end
      end
    end
  end
end
