# frozen_string_literal: true

require 'spec_helper'
require 'date'

RSpec.describe AcaEntities::Ledger::UserFeeReportItem do
  subject { described_class }

  let(:moment) { DateTime.now }

  let(:first_day_of_this_month) { Date.new(moment.year, moment.month, 1) }
  let(:last_day_of_this_month) { first_day_of_next_month - 1.day }
  let(:first_day_of_next_month) { Date.new(moment.next_month.year, moment.next_month.month, 1) }

  let(:user_fee_rate) { 0.03 }

  let(:sequence_value) { 1 }
  let(:subscriber_hbx_id) { '1138345' }

  let(:hios_id) { '96667' }
  let(:customer_id) { subscriber_hbx_id }
  let(:policy_subscriber_hbx_id) { subscriber_hbx_id }
  let(:enrolled_member_hbx_id) { subscriber_hbx_id }
  let(:enrolled_member_last_name) { 'Jetson' }
  let(:enrolled_member_first_name) { 'George' }
  let(:exchange_assigned_policy_id) { '68576' }
  let(:insurer_assigned_subscriber_id) { nil }
  let(:insurer_policy_id) { nil }
  let(:hbx_qhp_id) { '96667ME031005806' }
  let(:enrolled_member_billing_cycle_start_on) { first_day_of_this_month }
  let(:enrolled_member_billing_cycle_end_on) { last_day_of_this_month }
  let(:marketplace_segment_id) do
    [subscriber_hbx_id, exchange_assigned_policy_id, enrolled_member_billing_cycle_start_on.strftime('%Y%m%d')].join(
      '-'
    )
  end
  let(:user_fee_item_kind) { 'fee' }
  let(:aptc_amount) { 225.75.to_d }
  let(:enrolled_member_premium_amount) { 875.22.to_d }
  let(:enrolled_member_user_fee_amount) { (enrolled_member_premium_amount * user_fee_rate).to_d }
  let(:external_doc_reference) { nil }
  let(:created_at) { moment }
  let(:updated_at) { moment }

  let(:all_params) do
    {
      hios_id: hios_id,
      customer_id: customer_id,
      policy_subscriber_hbx_id: policy_subscriber_hbx_id,
      enrolled_member_hbx_id: enrolled_member_hbx_id,
      enrolled_member_last_name: enrolled_member_last_name,
      enrolled_member_first_name: enrolled_member_first_name,
      exchange_assigned_policy_id: exchange_assigned_policy_id,
      insurer_assigned_subscriber_id: insurer_assigned_subscriber_id,
      insurer_policy_id: insurer_policy_id,
      hbx_qhp_id: hbx_qhp_id,
      enrolled_member_billing_cycle_start_on: enrolled_member_billing_cycle_start_on,
      enrolled_member_billing_cycle_end_on: enrolled_member_billing_cycle_end_on,
      marketplace_segment_id: marketplace_segment_id,
      user_fee_item_kind: user_fee_item_kind,
      aptc_amount: aptc_amount,
      enrolled_member_premium_amount: enrolled_member_premium_amount,
      enrolled_member_user_fee_amount: enrolled_member_user_fee_amount,
      external_doc_reference: external_doc_reference,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  context 'Given valid params' do
    context 'and all params are present' do
      let(:contract) { AcaEntities::Ledger::Contracts::UserFeeReportItemContract.new }

      it 'should pass contract validation and create the UserFeeReportItem entity' do
        values = contract.call(all_params)
        expect(values.success?).to be_truthy
        result = subject.new(values.to_h)
        expect(result).to be_instance_of(AcaEntities::Ledger::UserFeeReportItem)
      end
    end
  end
end