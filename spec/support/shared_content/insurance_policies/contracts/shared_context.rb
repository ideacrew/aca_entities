# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

RSpec.shared_context 'insurance_policies_context' do
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  # InsuranceProdcutFeature
  let(:key) { 'pediatric_dental' }
  let(:title) { 'Pediatric Dental Coverage' }
  let(:description) { 'Plan includes dental essential benefits for all enrollees under age 19' }
  let(:value) { 100.00 }

  let(:shared_insurance_product_feature) { { key: key, title: title, description: description, value: value } }

  # PremiumSchedule
  let(:premium_amount) { 345.66 }
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
  let(:insurance_rate) { 575.23 }
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

  # Members & Enrolled Members
  let(:irs_group_id) { 'abc987' }
  let(:tax_household_id) { '6161' }
  let(:is_tobacco_user) { false }

  let(:george_jetson) do
    {
      enrolled_member: {
        member: {
          member_id: '1055668',
          insurer_assigned_id: 'HP597762000',
          person_name: {
            last_name: 'Jetson',
            first_name: 'George'
          },
          relationship_code: '1:18',
          encrypted_ssn: '012859874',
          dob: Date.new(1978, 12, 19),
          gender: 'male',
          irs_group_id: irs_group_id,
          tax_household_id: tax_household_id,
          addresses: addresses,
          phones: phones,
          emails: [{ kind: 'home', address: 'george.jetson@example.com' }]
        },
        enrolled_member_premium: {
          insurance_rate: 575.23,
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
          member_id: '1055678',
          insurer_assigned_id: 'HP597762002',
          person_name: {
            last_name: 'Jetson',
            first_name: 'Jane'
          },
          relationship_code: '4:19',
          encrypted_ssn: '012859875',
          dob: Date.new(1983, 9, 6),
          gender: 'female',
          irs_group_id: irs_group_id,
          tax_household_id: tax_household_id,
          addresses: addresses
        },
        enrolled_member_premium: {
          insurance_rate: 615.88,
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
          member_id: '1055689',
          insurer_assigned_id: 'HP597762001',
          person_name: {
            last_name: 'Jetson',
            first_name: 'Judy'
          },
          relationship_code: '2:01',
          dob: Date.new(2007, 2, 15),
          gender: 'female',
          irs_group_id: irs_group_id,
          tax_household_id: tax_household_id,
          addresses: addresses
        },
        enrolled_member_premium: {
          insurance_rate: 220.16,
          premium_schedule: premium_schedule
        },
        primary_care_provider: primary_care_provider,
        is_tobacco_user: is_tobacco_user
      }
    }
  end

  # EnrollmentElections
  let(:january_1) { Date.new(moment.year, 1, 1) }
  let(:march_121) { Date.new(moment.year, 3, 12) }
  let(:june_30) { Date.new(moment.year, 6, 30) }
  let(:december_31) { Date.new(moment.year, 12, 31) }

  ## InitialEnrollment
  let(:initial_enrollment_event_name) { 'enrolled' }
  let(:initial_enrollment_event_payload) { { description: 'payload stub for initial enrollment event' } }
  let(:initial_enrollment_subscriber) { george_jetson[:enrolled_member] }
  let(:initial_enrollment_dependents) { [jane_jetson[:enrolled_member]] }
  let(:initial_enrollment_effective_date) { january_1 }

  let(:initial_enrollment_election) do
    {
      enrollment_event_name: initial_enrollment_event_name,
      enrollment_event_payload: initial_enrollment_event_payload,
      subscriber: subscriber,
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
      enrollment_elections: enrollment_elections,
      subscriber_service_area_id: subscriber_service_area_id,
      subscriber_rating_area_id: subscriber_rating_area_id
    }
  end
end
