# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Determinations::EligibilityDeterminationContract do

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:issuer_profile_reference) do
    {
      hbx_id: '1234',
      fein: '123333333',
      hbx_carrier_id: '333333',
      name: 'Delta Dental',
      abbrev: 'DDPA'
    }
  end

  let(:product_reference) do
    {
      hios_id: '92479DC0020002',
      name: 'Access PPO',
      active_year: 2020,
      is_dental_only: false,
      metal_level: 'gold',
      product_kind: 'health',
      benefit_market_kind: 'aca_shop',
      ehb_percent: '0.0',
      issuer_profile_reference: issuer_profile_reference
    }
  end

  let!(:required_params) do
    {
      e_pdc_id: "3135650",
      benchmark_plan_id: product_reference,
      max_aptc: currency,
      premium_credit_strategy_kind: "unassisted",
      csr_percent_as_integer: 0,
      csr_eligibility_kind: "csr_0",
      aptc_csr_annual_household_income: currency,
      aptc_annual_income_limit: currency,
      csr_annual_income_limit: currency,
      determined_at: Date.today,
      source: "Curam"
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
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
        @result = subject.call(required_params.reject { |k, _v| k == :max_aptc })
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
        @result = subject.call(required_params.merge(benchmark_plan: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(source: "test"))
        expect(result.errors.messages.first.text).to eq('must be one of: Curam, Admin, Renewals, Faa, Ffe')
      end
    end
  end
end
