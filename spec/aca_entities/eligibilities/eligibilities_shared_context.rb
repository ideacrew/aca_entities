# frozen_string_literal: true

RSpec.shared_context 'eligibilities_shared_context' do
  let(:applicant_evidence_gid) do
    URI(
      'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555'
    )
  end
  let(:verification_outstanding) { 'outstanding' }
  let(:satisfied) { true }
  let(:unsatisfied) { false }
  let(:five_days_from_today) { Date.today + 5 }
  let(:now) { DateTime.now }

  let(:evidence_states_undetermined) do
    {
      income_evidence: {
        evidence_gid: applicant_evidence_gid,
        status: verification_outstanding,
        is_satisfied: unsatisfied,
        due_on: five_days_from_today,
        verification_outstanding: true,
        visited_at: now
      },
      esi_evidence: {
        evidence_gid: applicant_evidence_gid,
        status: verification_outstanding,
        is_satisfied: unsatisfied,
        due_on: five_days_from_today,
        verification_outstanding: true,
        visited_at: now
      },
      non_esi_evidence: {
        evidence_gid: applicant_evidence_gid,
        status: verification_outstanding,
        is_satisfied: unsatisfied,
        due_on: five_days_from_today,
        verification_outstanding: true,
        visited_at: now
      },
      local_mec_evidence: {
        evidence_gid: applicant_evidence_gid,
        status: verification_outstanding,
        is_satisfied: unsatisfied,
        due_on: five_days_from_today,
        verification_outstanding: true,
        visited_at: now
      }
    }
  end

  let(:aptc_evidence_items) do
    [
      {
        key: :income_evidence,
        title: 'Income',
        description: 'Applicant income and benefits',
        subject_ref: URI('gid://enroll_app/Family::FamilyMember'),
        evidence_ref: URI('gid://enroll_app/FinancialAssistance::Application')
      },
      {
        key: :esi_evidence,
        title: 'ESI',
        description: 'ESI benefits',
        subject_ref: URI('gid://enroll_app/Family::FamilyMember'),
        evidence_ref: URI('gid://enroll_app/FinancialAssistance::Application')
      },
      {
        key: :non_esi_evidence,
        title: 'Non-ESI',
        description: 'Non-ESI benefits',
        subject_ref: URI('gid://enroll_app/Family::FamilyMember'),
        evidence_ref: URI('gid://enroll_app/FinancialAssistance::Application')
      },
      {
        key: :local_mec_evidence,
        title: 'MEC',
        description: 'MEC benefits',
        subject_ref: URI('gid://enroll_app/Family::FamilyMember'),
        evidence_ref: URI('gid://enroll_app/FinancialAssistance::Application')
      }
    ]
  end

  let(:eligibility_snapshot) do
    {
      # Used by Visitor
      eligibility_items: [
        {
          key: 'aptc_csr_credit',
          evidence_items: [
            {
              key: :esi_evidence,
              subject_ref: 'gid://enroll_app/Family::FamilyMember',
              evidence_ref: 'gid://enroll_app/FinancialAssitance::Application'
            }
          ]
        }
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
                  status: 'determined',
                  is_satisfied: true,
                  verification_outstanding: false,
                  due_on: (Date.today + 21),
                  visited_at: DateTime.now
                },
                esi_evidence_state: {
                  subject_gid: 'gid://enroll_app/Family::FamilyMember/33333',
                  evidence_gid:
                    # Visitor call will include Family's current FAA application ID, e.g. 676767
                    # Visitor will map subject id: 33333 to evidence instance Appplicant ID, e.g. 555555
                    'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555',
                  status: 'determined',
                  is_satisfied: true,
                  verification_outstanding: false,
                  due_on: (Date.today + 21),
                  visited_at: DateTime.now
                }
              }
            }
          }
        }
      }
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
            es_2: {}
          }
        },
        el_2: {
          is_eligible: true,
          eligibility_states: {
            es_1: {},
            es_2: {}
          }
        }
      }
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
  end
end
