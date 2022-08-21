# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::PremiumCredits::TaxHouseholdEnrollmentContract, dbclean: :after_each do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:tax_household_reference) do
    {
      max_aptc: currency,
      monthly_expected_contribution: currency
    }
  end

  let(:hbx_enrollment_reference) do
    {
      hbx_id: "122333",
      effective_on: Date.today,
      aasm_state: 'coverage_selected',
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health'
    }
  end

  let(:hbx_enrollment_member_reference) do
    {
      is_subscriber: true,
      premium_amount: currency,
      applied_aptc_amount: currency,
      eligibility_date: Date.today,
      coverage_start_on: Date.today,
      coverage_end_on: nil,
      tobacco_use: 'no'
    }
  end

  let(:tax_household_member_reference) do
    {
      is_subscriber: true,
      reason: nil
    }
  end

  let(:tax_household_enrollment_members) do
    [
      {
        hbx_enrollment_member_id: hbx_enrollment_member_reference,
        tax_household_member_id: tax_household_member_reference,
        member_ehb_benchmark_health_premium: currency,
        member_ehb_benchmark_dental_premium: currency,
        age_on_effective_date: '25'
      }
    ]
  end

  let(:params) do
    {
      tax_household_id: tax_household_reference,
      hbx_enrollment_id: hbx_enrollment_reference,
      health_product_hios_id: 'health_product_hios_id',
      dental_product_hios_id: nil,
      total_benchmark_ehb_premium: currency,
      tax_household_enrollment_members: tax_household_enrollment_members
    }
  end

  context 'success case' do
    before do
      @result = subject.call(params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(params.reject { |k, _v| k == :tax_household_id })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(params.merge(tax_household_enrollment_members: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be an array')
      end

      it 'should return error message' do
        result = subject.call(params.merge(total_benchmark_ehb_premium: nil))
        expect(result.errors.messages.first.text).to eq('must be a hash')
      end
    end
  end
end
