# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::AccountEntryContract do
  subject { described_class.new }

  let(:credit_parent_account) { { number: 1200, name: 'A/R', kind: :asset } }
  let(:credit_account) { { number: 120_001, name: 'Carrier #1 A/R', kind: :asset, parent: credit_parent_account } }
  let(:debit_parent_account) { { number: 7200, name: 'A/R', kind: :liability } }
  let(:debit_account) { { number: 720_001, name: 'Carrier #1 A/R', kind: :liability, parent: debit_parent_account } }

  # before do
  #   Keepr::Account.create!(credit_parent_account)
  #   Keepr::Account.create!(debit_parent_account)
  #   Keepr::Account.create!(credit_account)
  #   Keepr::Account.create!(debit_account)
  # end

  let(:credit_side) { 'credit' }
  let(:debit_side) { 'debit' }
  let(:amount) { 155.0.to_d }
  let(:account_credit_entry) { { account: credit_account, amount: amount, side: credit_side } }
  let(:account_debit_entry) { { account: debit_account, amount: amount, side: debit_side } }

  let(:date) { Date.today }
  let(:credits) { [account_credit_entry] }
  let(:debits) { [account_debit_entry] }

  let(:required_params) { { date: date, debits: debits, credits: credits } }
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

  context 'Calling contract with Valid params' do
    context 'Calling the contract with no params' do
      let(:error_message) { { date: ['is missing'], credits: ['is missing'], debits: ['is missing'] } }
      it 'should pass validation' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
        expect(result.errors.to_h).to eq error_message
      end
    end
  end
end
