# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Enrollments::HbxEnrollment do

  let(:currency) do
    {
      cents: 98_700.0,
      currency_iso: "USD"
    }
  end

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let(:broker_role_reference) do
    {
      npn: '3333333333',
      person_reference: person_reference,
      broker_agency_reference: broker_agency_reference
    }
  end

  let(:coverage_household_members) do
    [
      {
        family_member_reference: family_member_reference,
        is_subscriber: true
      }
    ]
  end

  let(:coverage_households) do
    [
      {
        start_date: Date.today,
        is_immediate_family: true,
        is_determination_split_household: false,
        aasm_state: "applicant",
        broker_agency_reference: broker_agency_reference,
        broker_role_reference: broker_role_reference,
        coverage_household_members: coverage_household_members
      }
    ]
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

  let(:tax_households) do
    [
      {
        hbx_id: "828762",
        allocated_aptc: currency,
        is_eligibility_determined: true,
        start_date: Date.today,
        end_date: nil,
        tax_household_members: tax_household_members,
        eligibility_determinations: eligibility_determinations
      }
    ]
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

  let(:issuer_profile_reference) do
    {
      hbx_id: '1234',
      fein: '123333333',
      hbx_carrier_id: '333333',
      name: 'Delta Dental',
      abbrev: 'DDPA'
    }
  end

  let(:qualifying_life_event_kind_reference) do
    {
      start_on: Date.today,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
    }
  end

  let(:special_enrollment_period_reference) do
    {
      qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
      qle_on: Date.today,
      start_on: Date.today,
      end_on: Date.today, submitted_at: Date.today, effective_on: Date.today
    }
  end

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let(:event_response) do
    [
      {
        received_at: DateTime.now,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: DateTime.now,
        body: "request"
      }
    ]
  end

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: DateTime.now,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: nil,
      citizenship_result: nil,
      qualified_non_citizenship_result: nil,
      aasm_state: "verification_successful",
      ssa_responses: event_response,
      ssa_requests: event_request,
      vlp_responses: event_response,
      vlp_requests: event_request
    }
  end

  let(:consumer_role_reference) do
    {
      is_active: true,
      is_applying_coverage: true,
      is_applicant: true, is_state_resident: true,
      lawful_presence_determination: lawful_presence_determination,
      citizen_status: 'us_citizen'
    }
  end

  let(:resident_role_reference) do
    {
      is_applicant: true,
      is_active: true,
      is_state_resident: true,
      residency_determined_at: Date.today
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

  let(:coverage_household_reference) do
    {
      start_date: Date.today,
      is_immediate_family: false,
      is_determination_split_household: false
    }
  end

  let(:household_reference) do
    {}
  end

  let(:benefit_package_reference) do
    {
      title: 'test title',
      elected_premium_credit_strategy: 'unassisted'
    }
  end

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:benefit_coverage_period_reference) do
    {
      title: 'test title',
      market_place: 'individual',
      start_on: Date.today,
      end_on: Date.today,
      open_enrollment_start_on: Date.today,
      open_enrollment_end_on: Date.today
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

  let!(:input_params) do
    {
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health',
      hbx_id: '1000',
      aasm_state: 'coverage_selected',
      enrollment_kind: 'open_enrollment',
      coverage_kind: 'health',
      effective_on: Date.today,
      is_any_enrollment_member_outstanding: false,
      elected_amount: currency,
      elected_premium_credit: currency,
      applied_premium_credit: currency,
      elected_aptc_pct: 0.0, applied_aptc_amount: currency,
      aggregate_aptc_amount: currency,
      terminated_on: nil,
      terminate_reason: nil,
      enrollment_signature: nil,
      is_active: false,
      waiver_reason: nil,
      review_status: "incomplete",
      special_verification_period: Date.today,
      termination_submitted_on: nil,
      external_enrollment: false,
      coverage_household_reference: coverage_household_reference,
      family_hbx_id: "1000",
      special_enrollment_period_reference: special_enrollment_period_reference,
      product_reference: product_reference,
      issuer_profile_reference: issuer_profile_reference,
      consumer_role_reference: consumer_role_reference,
      resident_role_reference: resident_role_reference,
      broker_agency_reference: broker_agency_reference,
      broker_role_reference: broker_role_reference,
      predecessor_enrollment: hbx_enrollment_reference,
      benefit_package_reference: benefit_package_reference,
      benefit_coverage_period_reference: benefit_coverage_period_reference,
      updated_by: person_reference,
      hbx_enrollment_members: [hbx_enrollment_member_reference],
      tax_households_references: tax_households_references
    }
  end

  let(:tax_household_reference) do
    {
      hbx_id: '123456789',
      max_aptc: currency,
      yearly_expected_contribution: currency
    }
  end

  let(:non_tobacco_use_premium) do
    {
      cents: 220.0,
      currency_iso: "USD"
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
      coverage_start_on: Date.today,
      tobacco_use: 'Y',
      non_tobacco_use_premium: non_tobacco_use_premium,
      slcsp_member_premium: currency
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

  let(:tax_households_references) do
    [
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
    ]
  end

  describe 'slcsp_member_premium' do
    before do
      @validated_params_result = AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.new.call(input_params)
    end

    it 'returns slcsp_member_premium' do
      expect(@validated_params_result.success?).to be_truthy
      expect(
        @validated_params_result.to_h[:hbx_enrollment_members].first[:slcsp_member_premium]
      ).not_to be_empty
    end
  end

  describe 'non_tobacco_use_premium' do
    before do
      @validated_params_result = AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.new.call(input_params)
    end

    it 'return non_tobacco_use_premium' do
      expect(@validated_params_result.success?).to be_truthy
      expect(
        @validated_params_result.to_h[:hbx_enrollment_members].first[:tobacco_use]
      ).to eq 'Y'
      expect(
        @validated_params_result.to_h[:hbx_enrollment_members].first[:non_tobacco_use_premium]
      ).to eq non_tobacco_use_premium
    end
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
