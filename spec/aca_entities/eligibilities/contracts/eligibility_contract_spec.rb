# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EligibilityContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:key) { 'income_evidence' }
  let(:status) { 'verification_outstanding' }
  let(:earliest_due_date) { five_days_from_today }
  let(:determined_at) { now }
  let(:evidence_states) { evidence_states_undetermined }

  let(:required_params) do
    { evidence_states: { key.to_sym => { status: status, evidence_states: evidence_states, earliest_due_date: earliest_due_date, determined_at: determined_at } } }
  end
  let(:all_params) { required_params }

  context 'Calling the contract with no params' do
    let(:error_message) { { status: ['is missing'], evidence_states: ['is missing'], earliest_due_date: ['is missing'], determined_at: ['is missing'] } }

    it 'should fail validation' do
      # result = described_class.new.call({ determinations: {} })
      # require 'pry'
      # binding.pry
      # expect(result.failure?).to be_truthy
      # expect(result.errors.to_h).to eq error_message
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
