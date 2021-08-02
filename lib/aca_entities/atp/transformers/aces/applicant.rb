# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Applicant < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'person_hbx_id', 'role_reference.ref'
          add_key 'esi_eligible_indicator'
          add_key 'fixed_address_indicator'
          map 'attestation.is_incarcerated', 'incarcerations.incarceration_indicator'
          add_key 'incarcerations.incarceration_date'
          add_key 'absent_parent_or_spouse_code'
          map 'attestation.is_self_attested_disabled', 'is_self_attested_disabled', memoize: true, visible: false
          map 'attestation.is_self_attested_blind', 'is_self_attested_blind', memoize: true, visible: false
          add_key 'blindness_or_disability_indicator', function: lambda { |v|
            v.resolve('is_self_attested_disabled').item && v.resolve('is_self_attested_blind').item
          }
          add_key 'coverage_during_previous_six_months_indicator'
          add_key 'eligible_itu_services_indicator'
          add_key 'lawful_presence_status'
          map 'is_self_attested_long_term_care', 'long_term_care_indicator'
          add_key 'non_esi_coverage_indicators', value: ->(_v) {[]}
          add_key 'parent_caretaker_indicator'
          add_key 'received_itu_services_indicator'
          add_key 'recent_medical_bills_indicator'
          add_key 'state_benefits_through_public_employee_indicator'
          map 'student.is_student', 'student_indicator'
          add_key 'esi_associations', value: ->(_v) {[]}
          add_key 'non_esi_policies', value: ->(_v) {[]}
          add_key 'emergency_medicaid_eligibilities', value: ->(_v) {[]}
          add_key 'medicaid_magi_eligibilities', value: ->(_v) {[]}
          add_key 'medicaid_non_magi_eligibilities', value: ->(_v) {[]}
          add_key 'aptc_eligibilities', value: ->(_v) {[]}
          add_key 'exchange_eligibilities', value: ->(_v) {[]}
          add_key 'csr_eligibilities', value: ->(_v) {[]}
          add_key 'chip_eligibilities'
          add_key 'temporarily_lives_outside_application_state_indicator'
          map 'age_left_foster_care', 'age_left_foster_care'
          map 'foster_care_state', 'foster_care_state'
          map 'had_medicaid_during_foster_care', 'had_medicaid_during_foster_care_indicator'
          add_key 'lives_with_minor_age_dependent_indicator'
          add_key 'household_exception_indicator'
          map 'foster_care_indicator', 'foster_care_indicator'
          add_key 'parent_average_hours_worked_per_week_values'
        end
      end
    end
  end
end