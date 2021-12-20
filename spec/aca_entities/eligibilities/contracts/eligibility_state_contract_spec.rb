# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EligibilityStateContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:id) { 'zxy765' }
  # let(:eligibility_item_key) { 'aptc_csr_eligibility' }
  let(:is_eligible) { false }
  let(:evidence_states) { evidence_states_undetermined }
  let(:earliest_due_date) { five_days_from_today }
  let(:determined_at) { now }

  let(:required_params) do
    {
      # eligibility_item_key: eligibility_item_key,
      is_eligible: is_eligible,
      evidence_states: evidence_states,
      earliest_due_date: earliest_due_date,
      determined_at: determined_at
    }
  end

  let(:optional_params) { { id: id } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        # eligibility_item_key: ['is missing'],
        is_eligible: ['is missing'],
        evidence_states: ['is missing'],
        earliest_due_date: ['is missing'],
        determined_at: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({ determinations: {} })
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
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
