# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Households::TaxHouseholdGroup, dbclean: :after_each do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
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

  let(:enrollment_params) do
    {
      hbx_id: '11223344',
      effective_on: Date.today,
      aasm_state: 'coverage_selected',
      is_active: true,
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health'
    }
  end

  let(:enrolled_member_params) do
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

  let(:start_on) { Date.today }
  let(:end_on) {  Date.today }

  let(:accumulator_adjustment) do
    {
      enrollment: enrollment_params,
      enrolled_member: enrolled_member_params,
      start_on: start_on,
      end_on: end_on,
      amount: 1000
    }
  end

  let(:aptc_accumulator) do
    {
      maximum_amount: 1000,
      balance: 500,
      accumulator_adjustments: [accumulator_adjustment]
    }
  end

  let(:contribution_accumulator) do
    {
      maximum_amount: 1000,
      balance: 500,
      accumulator_adjustments: [accumulator_adjustment]
    }
  end

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

  let(:tax_household_members) do
    [
      { family_member_reference: family_member_reference,
        reason: "",
        is_subscriber: true,
        product_eligibility_determination: tax_household_member_eligibity_determination }
    ]
  end

  let(:tax_household_params) do
    {
      hbx_id: '123454321',
      allocated_aptc: currency,
      is_eligibility_determined: true,
      start_date: Date.today,
      end_date: Date.today,
      tax_household_members: tax_household_members,
      yearly_expected_contribution: BigDecimal('102.78238'),
      max_aptc: currency,
      aptc_accumulator: aptc_accumulator,
      contribution_accumulator: contribution_accumulator
    }
  end

  let(:input_params) do
    {
      hbx_id: '123456789',
      assistance_year: Date.today.year,
      start_on: Date.today,
      end_on: Date.today,
      source: 'Faa',
      application_reference: { hbx_id: '123454321' },
      tax_households: [tax_household_params]
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
end
