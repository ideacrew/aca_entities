# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Households::HouseholdContract, dbclean: :after_each do

  let!(:irs_group_reference) do
    {
      hbx_id: '44444'
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

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
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
        start_date: Date.today.to_s,
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
        determined_at: Date.today.to_s,
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
        start_date: Date.today.to_s,
        end_date: Date.today.to_s,
        tax_household_members: tax_household_members,
        eligibility_determinations: eligibility_determinations
      }
    ]
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
      start_on: Date.today.to_s,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
    }
  end

  let(:special_enrollment_period_reference) do
    {
      qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
      qle_on: Date.today.to_s,
      start_on: Date.today.to_s,
      end_on: Date.today.to_s, submitted_at: Date.today.to_s, effective_on: Date.today.to_s
    }
  end

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today.to_s,
      gender: 'male',
      ssn: nil
    }
  end

  let(:event_response) do
    [
      {
        received_at: Date.today.to_s,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: Date.today.to_s,
        body: "request"
      }
    ]
  end

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: Date.today.to_s,
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
      residency_determined_at: Date.today.to_s
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
      start_date: Date.today.to_s,
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
      start_on: Date.today.to_s,
      end_on: Date.today.to_s,
      open_enrollment_start_on: Date.today.to_s,
      open_enrollment_end_on: Date.today.to_s
    }
  end

  let(:hbx_enrollment_reference) do
    {
      hbx_id: "122333",
      effective_on: Date.today.to_s,
      aasm_state: 'coverage_selected',
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health'
    }
  end

  let!(:hbx_enrollments) do
    [
      {
        market_place_kind: 'individual',
        enrollment_period_kind: 'open_enrollment',
        product_kind: 'health',
        hbx_id: '1000',
        aasm_state: 'coverage_selected',
        enrollment_kind: 'open_enrollment',
        coverage_kind: 'health',
        effective_on: Date.today.to_s,
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
        special_verification_period: Date.today.to_s,
        termination_submitted_on: nil,
        external_enrollment: false,
        coverage_household_reference: coverage_household_reference,
        household_reference: household_reference,
        family_hbx_id: "1223",
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
        hbx_enrollment_members:
            [
              {
                family_member_reference: family_member_reference,
                carrier_member_id: nil,
                premium_amount: currency,
                applied_aptc_amount: currency,
                coverage_end_on: nil,
                is_subscriber: true,
                eligibility_date: Date.today.to_s,
                coverage_start_on: Date.today
              }
            ]
      }
    ]
  end

  let!(:required_params) do
    {
      start_date: Date.today.to_s,
      end_date: Date.today.to_s,
      is_active: true,
      submitted_at: Date.today.to_s,
      irs_group_reference: irs_group_reference,
      coverage_households: coverage_households,
      tax_households: tax_households,
      hbx_enrollments: hbx_enrollments
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
        @result = subject.call(required_params.reject { |k, _v| k == :coverage_households })
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
        @result = subject.call(required_params.merge(hbx_enrollments: nil))
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
