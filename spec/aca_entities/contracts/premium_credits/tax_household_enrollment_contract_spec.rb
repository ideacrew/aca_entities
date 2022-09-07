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
      hbx_id: '123456789',
      max_aptc: currency,
      yearly_expected_contribution: currency
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

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end

  let(:hbx_enrollment_member_reference) do
    {
      family_member_reference: family_member_reference,
      carrier_member_id: nil,
      premium_amount: currency,
      applied_aptc_amount: currency,
      coverage_end_on: nil,
      is_subscriber: true,
      eligibility_date: Date.today,
      coverage_start_on: Date.today
    }
  end

  let(:tax_household_member_reference) do
    {
      is_subscriber: true,
      reason: nil
    }
  end

  let(:tax_household_members_enrollment_members) do
    [
      {
        hbx_enrollment_member: hbx_enrollment_member_reference,
        tax_household_member: tax_household_member_reference,
        family_member_reference: { family_member_hbx_id: '1234567' },
        relationship_with_primary: 'child',
        date_of_birth: Date.today,
        age_on_effective_date: 25
      }
    ]
  end

  let(:params) do
    {
      tax_household_reference: tax_household_reference,
      hbx_enrollment_reference: hbx_enrollment_reference,
      health_product_hios_id: 'health_product_hios_id',
      dental_product_hios_id: nil,
      household_benchmark_ehb_premium: currency,
      household_health_benchmark_ehb_premium: currency,
      household_dental_benchmark_ehb_premium: nil,
      tax_household_members_enrollment_members: tax_household_members_enrollment_members
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
        @result = subject.call(params.reject { |k, _v| k == :tax_household_reference })
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
        @result = subject.call(params.merge(tax_household_members_enrollment_members: nil))
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
        result = subject.call(params.merge(household_benchmark_ehb_premium: nil))
        expect(result.errors.messages.first.text).to eq('must be a hash')
      end
    end
  end
end
