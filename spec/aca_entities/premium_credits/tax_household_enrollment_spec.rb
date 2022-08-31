# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::TaxHouseholdEnrollment, dbclean: :after_each do

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
        member_ehb_benchmark_health_premium: currency,
        member_ehb_benchmark_dental_premium: currency,
        age_on_effective_date: '25'
      }
    ]
  end

  let(:input_params) do
    {
      tax_household_reference: tax_household_reference,
      hbx_enrollment_reference: hbx_enrollment_reference,
      health_product_hios_id: 'health_product_hios_id',
      dental_product_hios_id: nil,
      household_benchmark_ehb_premium: currency,
      household_health_benchmark_ehb_premium: currency,
      household_health_benchmark_ehb_premium: nil,
      tax_household_members_enrollment_members: tax_household_members_enrollment_members
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
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :tax_household_reference
                            end)
      end.to raise_error(Dry::Struct::Error, /:tax_household_reference is missing/)
    end
  end
end
