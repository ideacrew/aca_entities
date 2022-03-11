# frozen_string_literal: true

require 'spec_helper'
require 'bigdecimal'
require 'bigdecimal/util'

RSpec.describe AcaEntities::Ledger::Contracts::TaxHouseholdContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:exchange_assigned_id) { '787878' }
  let(:assistance_year) { moment.year }
  let(:aptc_amount) { 585.69.to_d }
  let(:start_on) { Date.new(moment.year, moment.month, 1) }
  let(:end_on) { (start_on + 1.month).prev_day }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      assistance_year: assistance_year,
      exchange_assigned_id: exchange_assigned_id,
      aptc_amount: aptc_amount,
      start_on: start_on
    }
  end
  let(:optional_params) { { id: id, end_on: end_on, timestamps: timestamps } }

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
      {
        assistance_year: ['is missing'],
        exchange_assigned_id: ['is missing'],
        aptc_amount: ['is missing'],
        start_on: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
