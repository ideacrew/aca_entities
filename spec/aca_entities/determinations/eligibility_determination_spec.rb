# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Determinations::EligibilityDetermination do

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

  let!(:input_params) do
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

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(input_params.reject { |k, _v| k == :max_aptc }) }.to raise_error(Dry::Struct::Error, /:max_aptc is missing/)
    end
  end
end
