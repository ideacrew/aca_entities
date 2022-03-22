# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::UserFeeReportAccountContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:effective_year) { 2022 }
  let(:name) { '2022 Harvard Pilgrim User Fee' }
  let(:expense_account_name) { '2022 Harvard Pilgrim Member Full Premiums' }
  let(:description) { 'SBM Fees charged to Insurers' }
  let(:rate) { 3.0 }
  let(:parent_income_account) { { number: 4100, name: 'Carrier #1 A/R', kind: :asset } }
  let(:parent_expense_account) { { number: 8100, name: 'Carrier #1 Expense', kind: :liability } }

  let(:income_account) { { number: 410_010, name: name, kind: :revenue, parent: parent_income_account } }
  let(:expense_account) do
    { number: 810_010, name: expense_account_name, kind: :expense, parent: parent_expense_account }
  end

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { name: name, effective_year: effective_year, rate: rate, income_account: income_account } }
  let(:optional_params) do
    { id: id, name: name, description: description, expense_account: expense_account, timestamps: timestamps }
  end
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
    let(:error_message) { { effective_year: ['is missing'], income_account: ['is missing'], rate: ['is missing'] } }
    it 'should fail validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
