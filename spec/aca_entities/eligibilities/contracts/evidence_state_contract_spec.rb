# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::EvidenceStateContract do
  subject { described_class.new }

  let(:evidence_gid) { URI('gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555') }

  let(:status) { 'determined' }
  let(:is_satisfied) { false }
  let(:verification_outstanding) { true }
  let(:due_on) { Date.today + 1 }
  let(:visited_at) { DateTime.now }

  let(:optional_params) { {} }

  let(:required_params) do
    { evidence_gid: evidence_gid, visited_at: visited_at, status: status, is_satisfied: is_satisfied,
      verification_outstanding: verification_outstanding, due_on: due_on }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        evidence_gid: ['is missing'],
        visited_at: ['is missing'],
        status: ['is missing'],
        is_satisfied: ['is missing'],
        verification_outstanding: ['is missing'],
        due_on: ['is missing']
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
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Verify co-dependent is_satisfied and due_on attributes' do
    context 'When is_satisfied == false' do
      let(:valid_attribute_pair) { required_params.merge({ is_satisfied: false, due_on: Date.today }) }
      let(:invalid_attribute_pair) { required_params.merge({ is_satisfied: false, due_on: nil }) }
      let(:is_satisfied_true_error) { ['when is_satisfied is false, due_on must be present'] }

      it 'and due_on has a value it should validate' do
        result = subject.call(valid_attribute_pair)
        expect(result).to be_truthy
      end

      it 'and due_on is nil it should not validate' do
        result = subject.call(invalid_attribute_pair)
        expect(result.success?).to be_falsey
        expect(result.errors.to_h[:is_satisfied]).to eq is_satisfied_true_error
      end
    end

    context 'When is_satisfied == true' do
      let(:valid_attribute_pair) { required_params.merge({ is_satisfied: true, due_on: nil }) }
      let(:invalid_attribute_pair) { required_params.merge({ is_satisfied: true, due_on: Date.today }) }
      let(:is_satisfied_false_error) { ['when is_satisfied is true, due_on must be nil'] }

      it 'and due_on has a value it should not validate' do
        result = subject.call(valid_attribute_pair)
        expect(result.success?).to be_truthy
      end

      it 'and due_on is nil it should validate' do
        result = subject.call(invalid_attribute_pair)
        expect(result.success?).to be_falsey
        expect(result.errors.to_h[:is_satisfied]).to eq is_satisfied_false_error
      end
    end
  end
end
