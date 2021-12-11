# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # rubocop:disable Lint/Void
    # rubocop:disable Lint/BooleanSymbol
    # EnrollmentEligibilityEvidence
    class EnrollmentEligibilityEvidence
      # Event: 'aca_individual_market.verification_of_lawful_presence.expired'
      # Event: 'aca_individual_market.verification_of_lawful_presence.den'
      {
        marketplace: :aca_individual_market,
        key: :verification_of_lawful_presence,
        category: :enrollment,
        kind: :consumer_role,
        title: 'Verification of Lawful Presence',
        description: '',
        summary_status: :pending, # :applying, :pending, :determined
        status_expires_on: Date.next_week,
        is_eligible: :false, # => :true, :false, :pending
        workflow: {
          marketplace: :aca_individual_market,
          key: :vlp_workflow,
          title: 'Verification of Lawful Presence',
          description: '',
          process_steps: [
            {
              sequence_number: 1,
              begin_state: {
                title: 'Initial application not submitted',
                description: '',
                key: :applying
              },
              end_state: {
                title: 'Verification of Lawful Presence Requested',
                description: 'Applicant Lawful Presence Verification Requested',
                key: 'fdsh.vlp_service.eligibility_determination_requested'
              },
              assigned_to: {
                ea_user_id: '1234567'
              },
              due_on: Date.last_month,
              updated_by: {
                ea_admin_schedule_service_id: '1'
              },
              timestamp: {}
            },
            {
              sequence_number: 2,
              begin_state: {
                title: '',
                description: '',
                key: 'fdsh.vlp_service.negative_eligibility_determined'
              },
              end_state: {
                title: '',
                description: '',
                key: :supplemental_documentation_requested
              },
              assigned_to: {
                ea_user_id: '1234567'
              },
              due_on: Date.last_month,
              updated_by: {
                ea_admin_schedule_service_id: '1'
              },
              timestamp: {}
            },
            {
              sequence_number: 3,
              begin_state: {
                title: '',
                description: '',
                key: :supplemental_documentation_requested
              },
              end_state: {
                title: '',
                description: '',
                key: :documentation_final_notice_issued
              },
              assigned_to: {
                ea_user_id: '1234567'
              },
              due_on: Date.last_week,
              updated_by: {
                ea_admin_schedule_service_id: '1'
              },
              timestamp: {}
            },
            {
              sequence_number: 4,
              begin_state: {
                title: '',
                description: '',
                key: :documentation_final_notice_issued
              },
              end_state: {
                title: '',
                description: '',
                key: :case_assignment_pending
              },
              assigned_to: {
                ea_admin_schedule_service_id: '1'
              },
              due_on: Date.today,
              updated_by: {
                ea_admin_schedule_service_id: '1'
              },
              timestamp: {}
            },
            {
              sequence_number: 5,
              begin_state: {
                title: '',
                description: '',
                key: :case_assigned
              },
              end_state: {
                title: '',
                description: '',
                key: :supplemental_documentation_review_pending
              },
              assigned_to: {
                ea_csr_id: '1234567'
              },
              due_on: Date.next_week,
              updated_by: {
                ea_user_id: '1234567'
              },
              timestamp: {}
            }
          ]
        },
        timestamp: {}
      }
      attribute :title
      attribute :description
      attribute :marketplace
      attribute :key
      attribute :category
      attribute :kind
      attribute :is_satisfied
      attribute :status
      attribute :expires_on
      attribure :workflow
    end
    # rubocop:enable Lint/BooleanSymbol
    # rubocop:enable Lint/Void
  end
end
