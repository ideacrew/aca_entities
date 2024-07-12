# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::Contracts::SbmiPolicyContract do
  let(:required_params) do
    {
      record_control_number: 1,
      qhp_id: '1',
      rating_area: '1',
      exchange_policy_id: '1',
      exchange_subscriber_id: '1',
      coverage_start: Date.today,
      coverage_end: Date.today,
      effectuation_status: 'Y',
      insurance_line_code: 'insurance_line_code'
    }
  end

  let(:optional_params) do
    {
      issuer_policy_id: '1',
      issuer_subscriber_id: '1',
      coverage_household: [coverage_household_params],
      financial_loops: [financial_loop_params]
    }
  end

  let(:financial_loop_params) do
    {
      financial_effective_start_date: Date.today,
      financial_effective_end_date: Date.today,
      monthly_total_premium_amount: BigDecimal('100.00'),
      monthly_total_responsible_amount: BigDecimal('100.00')
    }
  end

  let(:coverage_household_params) do
    {
      exchange_assigned_memberId: "99921",
      subscriber_indicator: "Y",
      person_last_name: "SMITH",
      birth_date: Date.today.prev_year,
      postal_code: "12345",
      member_start_date: Date.today,
      member_end_date: Date.today,
      gender_code: "M"
    }
  end

  let(:error_messages) do
    {
      record_control_number: ['is missing'],
      qhp_id: ['is missing'],
      rating_area: ['is missing'],
      exchange_policy_id: ['is missing'],
      exchange_subscriber_id: ['is missing'],
      coverage_start: ['is missing'],
      coverage_end: ['is missing'],
      effectuation_status: ['is missing'],
      insurance_line_code: ['is missing']
    }
  end

  context 'failure case' do
    context 'missing_required params' do
      it 'should return failure' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end

      it 'should return error messages' do
        result = subject.call({})
        expect(result.errors.to_h).to eq error_messages
      end
    end
  end

  context 'success case' do
    context 'required params' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end
end
