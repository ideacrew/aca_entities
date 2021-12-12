# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::EvidenceStateContract do
  subject { described_class.new }

  let(:evidence_gid) { 'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555' }
  let(:state) { 'determined' }
  let(:is_satisfied) { false }
  let(:verification_outstanding) { true }
  let(:due_on) { Date.today + 1 }
  let(:visited_at) { DateTime.now }

  let(:optional_params) { {} }

  let(:required_params) do
    { evidence_gid: evidence_gid, visited_at: visited_at, state: state, is_satisfied: is_satisfied, verification_outstanding: verification_outstanding, due_on: due_on }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        evidence_gid: ['is missing'],
        visited_at: ['is missing'],
        state: ['is missing'],
        is_satisfied: ['is missing'],
        verification_outstanding: ['is missing'],
        due_on: ['is missing'],
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
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
end
