# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

RSpec.shared_context 'insurance_policies_context' do
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  # InsuranceAgreement
  let!(:contract_holder) { george_jetson[:enrolled_member][:member] }
  let(:insurance_provider) { shared_insurance_provider }
  let(:insurance_policies) { [shared_individual_insurance_policy] }
  let(:start_on) { january_1 }

  let(:shared_insurance_agreement) do
    {
      plan_year: DateTime.now.year,
      contract_holder: contract_holder,
      insurance_provider: insurance_provider,
      insurance_policies: insurance_policies,
      start_on: start_on
    }
  end

  # InsuranceProvider
  let(:hios_id) { '98765432' }
  let(:shared_insurance_provider_title) { 'Red Heart Healthcare' }
  let(:shared_insurance_products) { [shared_health_insurance_product] }
  let(:shared_insurance_policies) { [shared_individual_insurance_policy] }

  let(:shared_insurance_provider) do
    { hios_id: hios_id, title: shared_insurance_provider_title, fein: "12345",
      insurance_products: [shared_health_insurance_product] }
  end

  # InsuranceProductFeatures
  let(:key) { 'pediatric_dental' }
  let(:title) { 'Pediatric Dental Coverage' }
  let(:description) { 'Plan includes dental essential benefits for all enrollees under age 19' }
  let(:value) { 100.00 }

  let(:shared_health_insurance_product_feature) { { key: key, title: title, description: description, value: value } }

  # InsuranceProducts
  let(:shared_health_insurance_product_name) { 'Insurer Coverall Health Product' }
  let(:shared_health_insurance_product_features) { [shared_health_insurance_product_feature] }

  let(:shared_health_insurance_product) do
    { name: shared_health_insurance_product_name, insurance_product_features: shared_health_insurance_product_features,
      hios_plan_id: "123ME2345", plan_year: DateTime.now.year, coverage_type: "health",
      metal_level: "gold", market_type: "Individual", ehb: 0.93 }
  end

  let(:shared_dental_insurance_product_name) { 'Insurer Sparkle Dental Product' }
  let(:shared_dental_insurance_product) do
    { name: shared_dental_insurance_product_name, hios_plan_id: "123ME2345",
      plan_year: DateTime.now.year, coverage_type: "dental",
      metal_level: "bronze", market_type: "Individual", ehb: 0.93 }
  end

  # IndividualInsurancePolicy
  let(:policy_id) { 'policy_101' }
  let(:marketplace_segment_id) { '0130345-68576-20220201' }
  let(:coverage_kind) { 'hmo' }
  let(:insurance_product) { shared_health_insurance_product }

  let(:shared_individual_insurance_policy) do
    {
      policy_id: policy_id,
      marketplace_segment_id: marketplace_segment_id,
      coverage_kind: coverage_kind,
      insurance_product: insurance_product,
      insurance_provider: shared_insurance_provider,
      enrollments: [enrollment],
      hbx_enrollment_ids: [policy_id],
      start_on: Date.new(moment.year, 1, 1)
    }
  end

  # PremiumSchedule
  let(:premium_amount) {  { cents: 34_566.0, currency_iso: "USD" } }
  let(:insured_start_on) { Date.new(moment.year, 1, 1) }
  let(:insured_end_on) { Date.new(moment.year, 3, 1) }
  let(:valid_start_on) { Date.new(moment.year, 1, 1) }
  let(:valid_end_on) { Date.new(moment.year, 12, 31) }

  let(:premium_schedule) do
    {
      premium_amount: premium_amount,
      insured_start_on: insured_start_on,
      insured_end_on: insured_end_on,
      valid_start_on: valid_start_on,
      valid_end_on: valid_end_on
    }
  end

  # EnrolledMemberPremium
  let(:insurance_rate) { { cents: 57_523.0, currency_iso: "USD" }  }
  let(:enrolled_member_premium) { { premium_schedule: premium_schedule, insurance_rate: insurance_rate } }

  # PrimaryCareProvider
  let(:primary_care_provider) { { name: { first_name: 'Florence', last_name: 'Nightengale' } } }

  # Phones
  let(:phones) { [{ kind: 'mobile', primary: true, area_code: '208', number: '5551212', start_on: moment }] }

  # Address
  let(:addresses) do
    [
      {
        kind: 'home',
        address_1: '1406 Albright St',
        city: 'Boise',
        county_name: 'Ada',
        state_abbreviation: 'ID',
        zip_code: '83705',
        start_on: moment
      }
    ]
  end

  let(:emails) do
    [
      {
        kind: "home",
        address: "george.jetson@example.com"
      }
    ]
  end

  # Members & Enrolled Members
  let(:irs_group_id) { 'abc987' }
  let(:is_tobacco_user) { false }

  let(:george_jetson) do
    {
      enrolled_member: {
        member: {
          hbx_id: '1055668',
          member_id: '1055668',
          insurer_assigned_id: 'HP597762000',
          person_name: {
            last_name: 'Jetson',
            first_name: 'George'
          },
          encrypted_ssn: '012859874',
          dob: Date.new(1978, 12, 19),
          gender: 'male',
          addresses: addresses,
          phones: phones,
          emails: emails
        },
        enrolled_member_premium: {
          insurance_rate: insurance_rate,
          premium_schedule: premium_schedule
        },
        primary_care_provider: primary_care_provider,
        is_tobacco_user: is_tobacco_user
      }
    }
  end

  let(:jane_jetson) do
    {
      enrolled_member: {
        member: {
          hbx_id: '1055678',
          member_id: '1055678',
          insurer_assigned_id: 'HP597762002',
          person_name: {
            last_name: 'Jetson',
            first_name: 'Jane'
          },
          encrypted_ssn: '012859875',
          dob: Date.new(1983, 9, 6),
          gender: 'female',
          addresses: addresses
        },
        enrolled_member_premium: {
          insurance_rate: { cents: 61_588.0, currency_iso: "USD" },
          premium_schedule: premium_schedule
        },
        primary_care_provider: primary_care_provider,
        is_tobacco_user: is_tobacco_user
      }
    }
  end

  let(:judy_jetson) do
    {
      enrolled_member: {
        member: {
          hbx_id: '1055689',
          member_id: '1055689',
          insurer_assigned_id: 'HP597762001',
          person_name: {
            last_name: 'Jetson',
            first_name: 'Judy'
          },
          relationship_code: '2:01',
          dob: Date.new(2007, 2, 15),
          gender: 'female',
          addresses: addresses
        },
        enrolled_member_premium: {
          insurance_rate: { cents: 22_016.0, currency_iso: "USD" },
          premium_schedule: premium_schedule
        },
        primary_care_provider: primary_care_provider,
        is_tobacco_user: is_tobacco_user
      }
    }
  end

  # TaxHouseholdGroup

  let(:shared_tax_household_group_members) do
    [
      george_jetson[:enrolled_member][:member],
      jane_jetson[:enrolled_member][:member],
      judy_jetson[:enrolled_member][:member]
    ]
  end
  let(:tax_household_group_id) { 'th_101' }
  let(:assistance_year) { moment.year }
  let(:health_benchmark_plan) { shared_health_insurance_product }
  let(:dental_benchmark_plan) { shared_dental_insurance_product }
  let(:thh_aptc_amount) { 450.00 }
  let(:start_on) { january_1 }

  let(:shared_tax_household) do
    {
      tax_household_group_id: tax_household_group_id,
      assistance_year: assistance_year,
      members: shared_tax_household_group_members,
      health_benchmark_plan: health_benchmark_plan,
      dental_benchmark_plan: dental_benchmark_plan,
      max_aptc_amount: thh_aptc_amount,
      start_on: start_on
    }
  end

  # EnrollmentElections
  let(:january_1) { Date.new(moment.year, 1, 1) }
  let(:january_2) { Date.new(moment.year, 1, 2) }
  let(:march_121) { Date.new(moment.year, 3, 12) }
  let(:june_30) { Date.new(moment.year, 6, 30) }
  let(:december_31) { Date.new(moment.year, 12, 31) }

  ## InitialEnrollment
  let(:initial_enrollment_subscriber) { george_jetson[:enrolled_member] }
  let(:initial_enrollment_dependents) { [jane_jetson[:enrolled_member]] }
  let(:initial_enrollment_effective_date) { january_1 }
  let(:product_kind) { 'health' }
  let(:product) { shared_health_insurance_product }
  let(:coverage_kind) { 'hmo' }
  let(:coverage_level_kind) { 'silver' }
  let(:coverage_level_basis_kind) { 'in_network_coverage_payment' }

  let(:product_details) do
    {
      coverage_kind: coverage_kind,
      coverage_level_kind: coverage_level_kind,
      coverage_level_basis_kind: coverage_level_basis_kind
    }
  end

  let(:initial_enrollment_election) do
    {
      subscriber: enrollment_subscriber,
      product_kind: product_kind,
      product: product,
      product_details: product_details,
      effective_date: january_1,
      end_on: december_31
    }
  end

  ## DependentAdd
  let(:dependent_add_event_name) { 'dependent_added' }

  ## DependentDrop
  let(:dependent_drop_event_name) { 'dependent_dropped' }

  ## Cancelation
  let(:enrollment_canceled_event_name) { 'canceled' }

  ## Termination
  let(:enrollment_terminated_event_name) { 'terminated' }

  # Enrollment
  let(:enrollment_subscriber) { george_jetson[:enrolled_member] }
  let(:enrollment_dependents) { [jane_jetson[:enrolled_member]] }
  let(:enrollment_elections) { [initial_enrollment_election] }
  let(:subscriber_service_area_id) { 's101' }
  let(:subscriber_rating_area_id) { 'r101' }

  let(:enrollment) do
    {
      subscriber: enrollment_subscriber,
      dependents: enrollment_dependents,
      start_on: Date.new(moment.year, 1, 1)
    }
  end
end
