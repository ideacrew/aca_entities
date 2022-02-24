# frozen_string_literal: true

require 'spec_helper'
require 'date'

RSpec.describe AcaEntities::Ledger::UserFeeReport do
  subject { described_class }

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

  let(:all_params) do
    {
      hios_id: hios_id,
      user_fee_rate: user_fee_rate,
      billing_cycle_date: billing_cycle_date,
      premium_amount_total: premium_amount_total,
      user_fee_amount_total: user_fee_amount_total,
      adjustment_amount_total: adjustment_amount_total,
      user_fee_amount_due: user_fee_amount_due,
      id: id,
      user_fee_report_items: user_fee_report_items,
      report_timestamp: report_timestamp
    }
  end

  context 'Given valid params' do
    context 'and all params are present' do
      let(:contract) { AcaEntities::Ledger::Contracts::UserFeeReportContract.new }

      it 'should pass contract validation and create the UserFeeReport entity' do
        values = contract.call(all_params)
        expect(values.success?).to be_truthy
        result = subject.new(values.to_h)
        expect(result).to be_instance_of(AcaEntities::Ledger::UserFeeReport)
      end
    end
  end
end
