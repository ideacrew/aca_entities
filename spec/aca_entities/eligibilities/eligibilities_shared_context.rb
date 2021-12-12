# frozen_string_literal: true

RSpec.shared_context 'eligibilities_shared_context' do
  # {
  #   marketplace: 'aca_individual_market',
  #   products: [{ catastrophic_plans: false, eligibility_evidences: [{ key: :enrollment_members_overage_30, evidences: [] }], financial_assistance: {} }],
  # }

  let(:eligibility_snapshot) do
    {
      # Used by Visitor
      eligibility_items: [
        {
          key: 'aptc_csr_credit',
          evidence_items: [{ key: :esi_evidence, subject_ref: 'gid://enroll_app/Family::FamilyMember', evidence_ref: 'gid://enroll_app/FinancialAssitance::Application' }],
        },
      ],
      subjects: {
        'gid://enroll_app/Family::FamilyMember/22222': {
          determinations: {
            aptc_csr_credit: {
              status: 'eligible',
              determined_at: DateTime.now,
              earliest_due_date: Date.today + 1,
              evidence_states: {
                non_esi_evidence_state: {
                  evidence_gid:
                    # Visitor call will include Family's current FAA application ID, e.g. 676767
                    # Visitor will map subject id: 33333 to evidence instance Appplicant ID, e.g. 555555
                    'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555',
                  state: 'determined',
                  is_satisfied: true,
                  verification_outstanding: false,
                  due_on: (Date.today + 21),
                  visited_at: DateTime.now,
                },
                esi_evidence_state: {
                  subject_gid: 'gid://enroll_app/Family::FamilyMember/33333',
                  evidence_gid:
                    # Visitor call will include Family's current FAA application ID, e.g. 676767
                    # Visitor will map subject id: 33333 to evidence instance Appplicant ID, e.g. 555555
                    'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555',
                  state: 'determined',
                  is_satisfied: true,
                  verification_outstanding: false,
                  due_on: (Date.today + 21),
                  visited_at: DateTime.now,
                },
              },
            },
          },
        },
      },
    }
  end

  # AcaEntities::Eligibilities::EligibilityItem = { key: 'aptc_csr_credit', evidence_items: %i[esi non_esi income asus_mec] }
  # AcaEntities::Eligibilities::EvidenceItem = { key: 'esi', source: { source_klass_name: 'FinancialAssitance::Application::Applicant' } }

  let(:determination) do
    {
      subject_1: {
        el_1: {
          is_eligible: true,
          due_on: Date.today,
          eligibility_states: {
            es_1: {},
            es_2: {},
          },
        },
        el_2: {
          is_eligible: true,
          eligibility_states: {
            es_1: {},
            es_2: {},
          },
        },
      },
    }
  end

  let(:enrollment_eligibility_evidence) do
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
      is_eligible: false, # => :true, :false, :pending
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
              key: :applying,
            },
            end_state: {
              title: 'Verification of Lawful Presence Requested',
              description: 'Applicant Lawful Presence Verification Requested',
              key: 'fdsh.vlp_service.eligibility_determination_requested',
            },
            assigned_to: {
              ea_user_id: '1234567',
            },
            due_on: Date.last_month,
            updated_by: {
              ea_admin_schedule_service_id: '1',
            },
            timestamp: {},
          },
          {
            sequence_number: 2,
            begin_state: {
              title: '',
              description: '',
              key: 'fdsh.vlp_service.negative_eligibility_determined',
            },
            end_state: {
              title: '',
              description: '',
              key: :supplemental_documentation_requested,
            },
            assigned_to: {
              ea_user_id: '1234567',
            },
            due_on: Date.last_month,
            updated_by: {
              ea_admin_schedule_service_id: '1',
            },
            timestamp: {},
          },
          {
            sequence_number: 3,
            begin_state: {
              title: '',
              description: '',
              key: :supplemental_documentation_requested,
            },
            end_state: {
              title: '',
              description: '',
              key: :documentation_final_notice_issued,
            },
            assigned_to: {
              ea_user_id: '1234567',
            },
            due_on: Date.last_week,
            updated_by: {
              ea_admin_schedule_service_id: '1',
            },
            timestamp: {},
          },
          {
            sequence_number: 4,
            begin_state: {
              title: '',
              description: '',
              key: :documentation_final_notice_issued,
            },
            end_state: {
              title: '',
              description: '',
              key: :case_assignment_pending,
            },
            assigned_to: {
              ea_admin_schedule_service_id: '1',
            },
            due_on: Date.today,
            updated_by: {
              ea_admin_schedule_service_id: '1',
            },
            timestamp: {},
          },
          {
            sequence_number: 5,
            begin_state: {
              title: '',
              description: '',
              key: :case_assigned,
            },
            end_state: {
              title: '',
              description: '',
              key: :supplemental_documentation_review_pending,
            },
            assigned_to: {
              ea_csr_id: '1234567',
            },
            due_on: Date.next_week,
            updated_by: {
              ea_user_id: '1234567',
            },
            timestamp: {},
          },
        ],
      },
      timestamp: {},
    }
  end
end
