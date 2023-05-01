# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/vlp_document'
require 'aca_entities/atp/functions/immigration_document_builder'

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Applicant < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'person_hbx_id', 'role_reference.ref', memoize: true, visible: true, function: ->(v) {"pe#{v}"}
          add_key 'esi_eligible_indicator'
          map 'is_homeless', 'fixed_address_indicator'
          map 'attestation', 'attestation', memoize_record: true, visible: false
          add_key 'incarcerations', function: lambda { |v|
            attestation = v.resolve('attestation').item
            incarceration_date = { date: Date.today } if attestation[:is_incarcerated]
            [{ incarceration_indicator: attestation[:is_incarcerated], incarceration_date: incarceration_date }]
          }
          add_key 'absent_parent_or_spouse_code'
          map 'attestation.is_self_attested_disabled', 'is_self_attested_disabled', memoize: true, visible: false
          map 'attestation.is_self_attested_blind', 'is_self_attested_blind', memoize: true, visible: false
          add_key 'blindness_or_disability_indicator', function: lambda { |v|
            v.resolve('is_self_attested_disabled').item || v.resolve('is_self_attested_blind').item
          }
          map 'job_coverage_ended_in_past_3_months', 'coverage_during_previous_six_months_indicator'
          map 'citizenship_immigration_status_information.citizen_status', 'citizen_status', memoize: true, visible: false
          map 'vlp_document', 'vlp_document', memoize_record: true, visible: false
          add_key 'lawful_presence_status.lawful_presence_status_eligibility.eligibility_indicator', function: lambda { |v|
            v.resolve('citizen_status').item == 'alien_lawfully_present'
          }
          add_key 'lawful_presence_status.immigration_documents',
                  function: AcaEntities::Atp::Functions::ImmigrationDocumentBuilder.new
          map 'is_self_attested_long_term_care', 'long_term_care_indicator'
          map 'is_primary_caregiver', 'parent_caretaker_indicator'
          add_key 'state_benefits_through_public_employee_indicator'
          map 'student.is_student', 'student_indicator'
          add_key 'esi_associations', value: ->(_v) {[]}
          add_key 'emergency_medicaid_eligibilities', value: ->(_v) {[]}
          add_key 'medicaid_magi_eligibilities', value: ->(_v) {[]}
          add_key 'medicaid_non_magi_eligibilities', value: ->(_v) {[]}
          add_key 'aptc_eligibilities', value: ->(_v) {[]}
          add_key 'exchange_eligibilities', value: ->(_v) {[]}
          add_key 'csr_eligibilities', value: ->(_v) {[]}
          add_key 'chip_eligibilities'
          map 'is_temporarily_out_of_state', 'temporarily_lives_outside_application_state_indicator'

          map 'foster_care.age_left_foster_care', 'age_left_foster_care'
          map 'foster_care.foster_care_us_state', 'foster_care_state'
          map 'foster_care.had_medicaid_during_foster_care', 'had_medicaid_during_foster_care_indicator'
          add_key 'lives_with_minor_age_dependent_indicator'
          add_key 'household_exception_indicator'
          map 'foster_care.is_former_foster_care', 'foster_care_indicator'
          add_key 'parent_average_hours_worked_per_week_values'

          map 'native_american_information.indian_tribe_member', 'indian_tribe_member', memoize: true, visible: false
          map 'other_health_service.is_eligible', 'is_eligible', memoize: true, visible: false
          map 'other_health_service.has_received', 'has_received', memoize: true, visible: false

          add_key 'eligible_itu_services_indicator', function: lambda { |v|
            v.resolve('indian_tribe_member').item && v.resolve('is_eligible').item
          }
          add_key 'received_itu_services_indicator', function: lambda { |v|
            v.resolve('indian_tribe_member').item && v.resolve('has_received').item
          }

          map 'need_help_paying_bills', 'recent_medical_bills_indicator'
          add_key 'referral_activity.activity_id.identification_id', function: lambda {|v|
            ["SBM", DateTime.now.strftime("%Y%m%d%H%M%S"), v.resolve('role_reference.ref').item&.slice(-3..-1)].join
          }
          add_key 'referral_activity.activity_date.date_time', value: ->(_v) {DateTime.now} # default value
          add_key 'referral_activity.sender_reference.ref', value: "Sender"
          add_key 'referral_activity.receiver_reference.ref', value: "medicaidReceiver"
          add_key 'referral_activity.status.status_code', value: "Initiated" # default value
          add_key 'referral_activity.reason_code', value: "FullDetermination" # default value
        end
      end
    end
  end
end