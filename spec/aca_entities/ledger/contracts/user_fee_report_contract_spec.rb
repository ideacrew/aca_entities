# frozen_string_literal: true

require 'spec_helper'
require 'date'

RSpec.describe AcaEntities::Ledger::Contracts::UserFeeReportContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:user_fee_rate) { 0.03 }

  let(:id) { '12345' }
  let(:hios_id) { '96667' }
  let(:billing_cycle_date) { Date.new(moment.year, moment.month, 1) }
  let(:premium_amount_total) { 1_000_000_000.0 }
  let(:user_fee_amount_total) { premium_amount_total * user_fee_rate }
  let(:adjustment_amount_total) { -25_000.0 }
  let(:user_fee_amount_due) { premium_amount_total + adjustment_amount_total }
  let(:user_fee_report_items) { [] }

  let(:report_timestamp) { DateTime.new(moment.next_month.year, moment.next_month.month, 1) }

  let(:required_params) do
    {
      hios_id: hios_id,
      user_fee_rate: user_fee_rate,
      billing_cycle_date: billing_cycle_date,
      premium_amount_total: premium_amount_total,
      user_fee_amount_total: user_fee_amount_total,
      adjustment_amount_total: adjustment_amount_total,
      user_fee_amount_due: user_fee_amount_due
    }
  end

  let(:optional_params) { { id: id, user_fee_report_items: user_fee_report_items, report_timestamp: report_timestamp } }
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
        hios_id: ['is missing'],
        user_fee_rate: ['is missing'],
        billing_cycle_date: ['is missing'],
        premium_amount_total: ['is missing'],
        user_fee_amount_total: ['is missing'],
        adjustment_amount_total: ['is missing'],
        user_fee_amount_due: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
