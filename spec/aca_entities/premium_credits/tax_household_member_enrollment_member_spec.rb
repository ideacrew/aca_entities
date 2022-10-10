# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::TaxHouseholdMemberEnrollmentMember, dbclean: :after_each do

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
      family_member_reference: family_member_reference,
      is_subscriber: true,
      reason: nil
    }
  end

  let(:input_params) do
    {
      hbx_enrollment_member: hbx_enrollment_member_reference,
      tax_household_member: tax_household_member_reference,
      family_member_reference: { family_member_hbx_id: '1234567' },
      relationship_with_primary: 'child',
      date_of_birth: Date.today,
      age_on_effective_date: 25
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
                              k == :hbx_enrollment_member
                            end)
      end.to raise_error(Dry::Struct::Error, /:hbx_enrollment_member is missing/)
    end
  end
end
