# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::TransactionHeaderContract do
  subject { described_class.new }

  let(:code) { 1 }
  let(:application_extract_time) { DateTime.now }
  let(:policy_maintenance_time) { application_extract_time }

  let(:required_params) do
    { code: code, application_extract_time: application_extract_time, policy_maintenance_time: policy_maintenance_time }
  end
  let(:optional_params) { {} }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      { code: ['is missing'], application_extract_time: ['is missing'], policy_maintenance_time: ['is missing'] }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
