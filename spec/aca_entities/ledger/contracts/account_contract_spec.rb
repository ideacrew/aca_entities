# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::AccountContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:number) { 1_200_001 }
  let(:name) { 'Accounts Receivable' }
  let(:kind) { :asset }
  let(:parent_account) { { number: 1200, name: 'Carrier #1 A/R', kind: :asset } }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { number: number, name: name, kind: kind } }
  let(:optional_params) { { id: id, parent: parent_account, timestamps: timestamps } }

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
    let(:error_message) { { kind: ['is missing'], name: ['is missing'], number: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with an invalid kind attribute' do
    let(:invalid_kind) { 'turnip' }
    let(:invalid_params) { all_params.merge(kind: invalid_kind) }
    let(:error_message) { { kind: ['must be one of: asset, liability, revenue, expense, forward, debtor, creditor'] } }
    it 'should pass validation' do
      result = subject.call(invalid_params)
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
