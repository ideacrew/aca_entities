# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

RSpec.shared_context 'insurance_policies_context' do
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

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
  let(:phones) { [{ kind: 'mobile', primary: true, area_code: 208, number: 5_551_212, start_on: moment }] }

  # Address
  let(:addresses) do
    [
      {
        kind: 'primary',
        line_1: '1406 Albright St',
        city: 'Boise',
        county: 'Ada',
        state: 'ID',
        zip: '83705',
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
        tax_household_id: tax_household_id
      },
      enrolled_member: {
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
        tax_household_id: tax_household_id
      },
      enrolled_member: {
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
        emails: 'jetsons@example.com'
      },
      enrolled_member: {
        enrolled_member_premium: {
          insurance_rate: 220.16,
          premium_schedule: premium_schedule
        },
        primary_care_provider: primary_care_provider,
        is_tobacco_user: is_tobacco_user
      }
    }
  end

  # EnrolledMembers
  let(:is_tobacco_user) { false }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:is_active) { true }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }
  let(:start_on) { Date.new(moment.to_date.year, 1, 1) }
  let(:end_on) { Date.new(moment.to_date.year, 12, 31) }
end
