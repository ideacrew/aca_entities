# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/vlp_document'
require 'aca_entities/atp/functions/immigrant_document_builder'

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Applicant < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'person_hbx_id', 'role_reference.ref', function: ->(v) {"IDC#{v}"}
          add_key 'esi_eligible_indicator'
          map 'is_homeless', 'fixed_address_indicator'
          map 'attestation', 'attestation', memoize_record: true, visible: false
          add_key 'incarcerations', function: lambda { |v|
            attestation = v.resolve('attestation').item
            [{ incarceration_indicator: attestation[:is_incarcerated], incarceration_date:  { date: Date.today } }]
          }
          add_key 'absent_parent_or_spouse_code'
          map 'attestation.is_self_attested_disabled', 'is_self_attested_disabled', memoize: true, visible: false
          map 'attestation.is_self_attested_blind', 'is_self_attested_blind', memoize: true, visible: false
          add_key 'blindness_or_disability_indicator', function: lambda { |v|
            v.resolve('is_self_attested_disabled').item && v.resolve('is_self_attested_blind').item
          }
          add_key 'coverage_during_previous_six_months_indicator'
          add_key 'eligible_itu_services_indicator'
          map 'vlp_document', 'vlp_document', memoize_record: true, visible: false
          add_key 'lawful_presence_status.immigrant_documents', function: AcaEntities::Atp::Functions::ImmigrantDocumentBuilder.new                             
          # namespace 'vlp_document' do
          #   rewrap 'lawful_presence_status.immigrant_documents', type: :array do
          #     add_key 'category_text'
          #     add_key 'document_person_ids'
          #     # map 'vlp_subject', 'category_code'
          #     map 'alien_number', 'document_numbers.identification_id'
          #     map 'i94_number', 'document_numbers.identification_id'
          #     # map 'visa_number', 'document_numbers.identification_id'
          #     # map 'passport_number', 'document_numbers.identification_id'
          #     # map 'sevis_number', 'document_numbers.identification_id'
          #     # map 'naturalization_number', 'document_numbers.identification_id'
          #     # map 'receipt_number', 'document_numbers.identification_id'
          #     # map 'citizenship_number', 'document_numbers.identification_id'
          #     # map 'card_number', 'document_numbers.identification_id'
          #     # map 'country_of_citizenship', 'document_numbers.identification_jurisdiction'
          #     # map 'issuing_country', 'document_numbers.identification_jurisdiction'
          #     # map 'expiration_date', 'expiration_date.date'
          #   end
          # end
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

          add_key 'referral_activity.activity_id.identification_id', value: "FFM45358121961474116" # default value
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