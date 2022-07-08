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
    context 'and all required params are present' do
      let(:contract) { AcaEntities::Ledger::Contracts::UserFeeReportItemContract.new }

      it 'should pass contract validation and create the UserFeeReportItem entity' do
        values = contract.call(all_params)
        expect(values.success?).to be_truthy
        result = subject.new(values.to_h)
        expect(result).to be_instance_of(AcaEntities::Ledger::UserFeeReportItem)
      end
    end
  end

  context 'Given various enrollment date periods' do
    let(:one_day) { [Date.new(2022, 1, 1), Date.new(2022, 1, 1)] }
    let(:one_month) { [Date.new(2022, 1, 1), Date.new(2022, 1, 31)] }
    let(:one_month_late_start) { [Date.new(2022, 1, 15), Date.new(2022, 1, 31)] }
    let(:one_month_early_end) { [Date.new(2022, 1, 1), Date.new(2022, 1, 20)] }
    let(:one_month_late_start_and_early_end) { [Date.new(2022, 1, 15), Date.new(2022, 1, 27)] }

    let(:three_months) { [Date.new(2022, 1, 1), Date.new(2022, 3, 31)] }
    let(:three_months_late_start) { [Date.new(2022, 1, 15), Date.new(2022, 3, 31)] }
    let(:three_months_early_end) { [Date.new(2022, 1, 1), Date.new(2022, 3, 20)] }
    let(:three_months_late_start_and_early_end) { [Date.new(2022, 1, 15), Date.new(2022, 3, 27)] }

    let(:x_year_three_months) { [Date.new(2022, 12, 1), Date.new(2023, 2, 28)] }
    let(:x_year_three_months_late_start) { [Date.new(2022, 12, 15), Date.new(2023, 2, 28)] }
    let(:x_year_three_months_early_end) { [Date.new(2022, 12, 1), Date.new(2023, 2, 20)] }
    let(:x_year_three_months_late_start_and_early_end) { [Date.new(2022, 12, 15), Date.new(2023, 2, 27)] }

    let(:contract) { AcaEntities::Ledger::Contracts::UserFeeReportItemContract.new }
    let(:item) { subject.new(contract.call(all_params).to_h) }

    context '#months_between_dates' do
      it 'should calculate zero months for a one month period' do
        expect(item.months_between_dates(one_day[0], one_day[1])).to eq 1
        expect(item.months_between_dates(one_month[0], one_month[1])).to eq 1
        expect(item.months_between_dates(one_month_late_start[0], one_month_late_start[1])).to eq 1
        expect(item.months_between_dates(one_month_early_end[0], one_month_early_end[1])).to eq 1
        expect(
          item.months_between_dates(one_month_late_start_and_early_end[0], one_month_late_start_and_early_end[1])
        ).to eq 1
      end

      it 'should calculate three months for three month period within a single year' do
        expect(item.months_between_dates(three_months[0], three_months[1])).to eq 3
        expect(item.months_between_dates(three_months_late_start[0], three_months_late_start[1])).to eq 3
        expect(item.months_between_dates(three_months_early_end[0], three_months_early_end[1])).to eq 3
        expect(
          item.months_between_dates(three_months_late_start_and_early_end[0], three_months_late_start_and_early_end[1])
        ).to eq 3
      end

      it 'should calculate three months for a three month period across years' do
        expect(item.months_between_dates(x_year_three_months[0], x_year_three_months[1])).to eq 3
        expect(item.months_between_dates(x_year_three_months_late_start[0], x_year_three_months_late_start[1])).to eq 3
        expect(item.months_between_dates(x_year_three_months_early_end[0], x_year_three_months_early_end[1])).to eq 3
        expect(
          item.months_between_dates(
            x_year_three_months_late_start_and_early_end[0],
            x_year_three_months_late_start_and_early_end[1]
          )
        ).to eq 3
      end
    end

    context '#split_date_period_to_months' do
      let(:one_month_split) { [[Date.new(2022, 1, 1), Date.new(2022, 1, 31)]] }

      let(:three_months_split) do
        [
          [Date.new(2022, 1, 1), Date.new(2022, 1, 31)],
          [Date.new(2022, 2, 1), Date.new(2022, 2, 28)],
          [Date.new(2022, 3, 1), Date.new(2022, 3, 31)]
        ]
      end

      let(:three_months_late_start_split) do
        [
          [Date.new(2022, 1, 15), Date.new(2022, 1, 31)],
          [Date.new(2022, 2, 1), Date.new(2022, 2, 28)],
          [Date.new(2022, 3, 1), Date.new(2022, 3, 31)]
        ]
      end

      let(:three_months_early_end_split) do
        [
          [Date.new(2022, 1, 1), Date.new(2022, 1, 31)],
          [Date.new(2022, 2, 1), Date.new(2022, 2, 28)],
          [Date.new(2022, 3, 1), Date.new(2022, 3, 20)]
        ]
      end

      let(:three_months_late_start_and_early_end_split) do
        [
          [Date.new(2022, 1, 15), Date.new(2022, 1, 31)],
          [Date.new(2022, 2, 1), Date.new(2022, 2, 28)],
          [Date.new(2022, 3, 1), Date.new(2022, 3, 27)]
        ]
      end

      it 'should calculate correct number of days for each month' do
        expect(item.split_date_period_to_months(one_month[0], one_month[1])).to eq one_month_split
        expect(item.split_date_period_to_months(three_months[0], three_months[1])).to eq three_months_split
        expect(
          item.split_date_period_to_months(three_months_late_start[0], three_months_late_start[1])
        ).to eq three_months_late_start_split
        expect(
          item.split_date_period_to_months(three_months_early_end[0], three_months_early_end[1])
        ).to eq three_months_early_end_split
        expect(
          item.split_date_period_to_months(
            three_months_late_start_and_early_end[0],
            three_months_late_start_and_early_end[1]
          )
        ).to eq three_months_late_start_and_early_end_split
      end
    end

    context '#calculate_premium' do
      let(:premium_amount) { 100.0 }
      let(:three_months_premium_amount) { 300.0 }
      let(:one_month_late_start_premium_amount) { BigDecimal((premium_amount / 31 * (31 - 15 + 1)).to_s).round(2).to_f }
      let(:three_months_late_start_and_early_end_premium_amount) do
        BigDecimal(((premium_amount / 31 * (31 - 15 + 1)) + premium_amount + (premium_amount / 31 * (27 + 0))).to_s)
          .round(2)
          .to_f
      end

      it 'should correctly calculate the premium' do
        expect(item.calculate_premium(one_month[0], one_month[1], premium_amount)).to eq premium_amount
        expect(
          item.calculate_premium(three_months[0], three_months[1], premium_amount)
        ).to eq three_months_premium_amount
        expect(
          item.calculate_premium(one_month_late_start[0], one_month_late_start[1], premium_amount)
        ).to eq one_month_late_start_premium_amount
        expect(
          item.calculate_premium(
            three_months_late_start_and_early_end[0],
            three_months_late_start_and_early_end[1],
            premium_amount
          )
        ).to eq three_months_late_start_and_early_end_premium_amount
      end
    end

    context '#calculate_user_fee' do
      let(:user_fee_factor) { 0.035 }
      let(:zero_premium_amount) { 0.00 }
      let(:positive_premium_amount) { 125.65 }
      let(:positive_premium_user_fee_amount) do
        BigDecimal((positive_premium_amount * user_fee_factor).to_s).round(2).to_f
      end

      it 'should return 0.00 for zero premium' do
        expect(item.calculate_user_fee(zero_premium_amount)).to eq zero_premium_amount
      end

      it 'should return correct amount for a positive premium and user_fee_factor' do
        expect(item.calculate_user_fee(positive_premium_amount, user_fee_factor)).to eq positive_premium_user_fee_amount
      end
    end

    context '#days_in_month' do
      let(:leap_year_february) { Date.new(2020, 2, 1) }
      let(:non_leap_year_february) { Date.new(2022, 2, 1) }
      let(:october) { Date.new(2022, 10, 1) }

      it 'should calculate correct number of days for each month' do
        expect(item.days_in_month(leap_year_february.year, leap_year_february.month)).to eq 29
        expect(item.days_in_month(non_leap_year_february.year, non_leap_year_february.month)).to eq 28
        expect(item.days_in_month(october.year, october.month)).to eq 31
      end
    end
  end
end
