# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::AccountCreditEntryContract do
  subject { described_class.new }

  let(:account) { { number: 120_001, name: 'Carrier #1 A/R', kind: :asset } }
  let(:side) { 'credit' }
  let(:amount) { 155.0.to_d }
  let(:required_params) { { account: account, amount: amount, side: side } }
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
    let(:error_message) { { account: ['is missing'], amount: ['is missing'], side: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with an invalid side attribute' do
    let(:invalid_side) { 'turnip' }
    let(:invalid_params) { all_params.merge(side: invalid_side) }
    let(:error_message) { { side: ['must be one of: credit, debit'] } }
    it 'should fail validation' do
      result = subject.call(invalid_params)
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
