# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::AccountContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:name) { 'M&T Bank' }
  let(:description) { 'Checking Account' }
  let(:number) { '100010' }
  let(:category) { 'accounts_receivable' }
  let(:kind) { 'accounts_receivable' }
  let(:is_active) { true }
  let(:scope) { 'vendor' }
  let(:balance) { 585.69 }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { {} }
  let(:optional_params) do
    {
      is_active: is_active,
      id: id,
      name: name,
      description: description,
      number: number,
      category: category,
      kind: kind,
      scope: scope,
      balance: balance,
      timestamps: timestamps
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    it 'should pass validation' do
      result = subject.call({})
      expect(result.success?).to be_truthy
    end
  end
end
