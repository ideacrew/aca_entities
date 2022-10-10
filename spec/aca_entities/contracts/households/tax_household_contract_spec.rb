# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Households::TaxHouseholdContract, dbclean: :after_each do

  let(:tax_household_member_eligibity_determination) do
    {
      is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_totally_ineligible: false,
      is_uqhp_eligible: false,
      is_non_magi_medicaid_eligible: false,
      magi_as_percentage_of_fpl: 0.0,
      magi_medicaid_type: nil,
      magi_medicaid_category: nil,
      magi_medicaid_monthly_household_income: currency,
      magi_medicaid_monthly_income_limit: currency,
      medicaid_household_size: nil,
      is_without_assistance: false
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

  let(:tax_household_members) do
    [
      { family_member_reference: family_member_reference,
        reason: "",
        is_subscriber: true,
        product_eligibility_determination: tax_household_member_eligibity_determination }
    ]
  end

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
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

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let!(:eligibility_determinations) do
    [
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
    ]
  end

  let(:required_params) do
    {
      hbx_id: "828762",
      allocated_aptc: currency,
      is_eligibility_determined: true,
      start_date: Date.today,
      end_date: nil,
      tax_household_members: tax_household_members,
      yearly_expected_contribution: { cents: 10_278_238, currency_iso: "USD" },
      eligibility_determinations: eligibility_determinations
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
        @result = subject.call(required_params.reject { |k, _v| k == :tax_household_members })
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
        @result = subject.call(required_params.merge(tax_household_members: nil))
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
        result = subject.call(required_params.merge(start_date: nil))
        expect(result.errors.messages.first.text).to eq('must be a date')
      end
    end
  end
end


