# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::DeterminationContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:eligibility_item_key) { 'aptc_csr_eligibility' }
  let(:status) { 'verification_outstanding' }
  let(:evidence_states) { evidence_states_undetermined }
  let(:earliest_due_date) { five_days_from_today }
  let(:determined_at) { now }

  let(:required_params) do
    {
      status: status,
      evidence_states: evidence_states,
      earliest_due_date: earliest_due_date,
      determined_at: determined_at
    }
  end

  let(:all_params) { required_params }

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        status: ['is missing'],
        evidence_states: ['is missing'],
        earliest_due_date: ['is missing'],
        determined_at: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with an invalid evidence_state' do
    let(:invalid_evidence_state) do
      {
        income_evidence: {
          evidence_gid: applicant_evidence_gid,
          state: verification_outstanding,
          verification_outstanding: true,
          visited_at: now
        }
      }
    end

    let(:invalid_params) do
      all_params.merge(evidence_states: invalid_evidence_state)
    end

    let(:invalid_params_error) do
      {
        evidence_states: {
          income_evidence: [
            {
              code: {
                due_on: ['is missing'],
                is_satisfied: ['is missing']
              },
              text: 'error'
            }
          ]
        }
      }
    end
    it 'should fail validation' do
      result = described_class.new.call(invalid_params)

      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq invalid_params_error
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
