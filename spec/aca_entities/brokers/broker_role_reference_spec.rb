# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Brokers::BrokerRoleReference do

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

  let(:input_params) do
    {
      npn: '3333333333',
      person_reference: person_reference,
      broker_agency_reference: broker_agency_reference
    }
  end

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
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
                              k == :broker_agency_reference
                            end)
      end.to raise_error(Dry::Struct::Error, /:broker_agency_reference is missing/)
    end
  end
end
