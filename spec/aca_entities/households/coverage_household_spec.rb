# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Households::CoverageHousehold, dbclean: :after_each do

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
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

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'first name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
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

  let(:input_params) do
    {
      start_date: Date.today,
      is_immediate_family: true,
      is_determination_split_household: false,
      aasm_state: "applicant",
      broker_agency_reference: broker_agency_reference,
      broker_role_reference: broker_role_reference,
      coverage_household_members: coverage_household_members
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
                              k == :coverage_household_members
                            end)
      end.to raise_error(Dry::Struct::Error, /:coverage_household_members is missing/)
    end
  end
end

