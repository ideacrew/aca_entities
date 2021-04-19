# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::GeneralAgencies::GeneralAgencyAccount, dbclean: :after_each do

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      last_name: 'last name',
      middle_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
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

  let(:general_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let!(:input_params) do
    {
      start_on: Date.today,
      end_on: Date.today,
      is_active: false,
      aasm_state: 'active',
      general_agency_reference: general_agency_reference,
      broker_role_reference: broker_role_reference,
      updated_by: person_reference
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
      expect { described_class.new(input_params.reject { |k, _v| k == :start_on }) }.to raise_error(Dry::Struct::Error, /:start_on is missing/)
    end
  end
end

