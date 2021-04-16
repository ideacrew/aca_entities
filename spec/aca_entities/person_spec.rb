# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/phone'
require 'aca_entities/email'
require 'aca_entities/address'
require 'aca_entities/person'

RSpec.describe ::AcaEntities::Person, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { names: [],
        first_name: 'ivl40', last_name: '41',
        dob: Date.today.prev_year, ssn: '345343243',
        gender: 'male', is_incarcerated: false,
        same_with_primary: true, indian_tribe_member: true, citizen_status: 'true',
        addresses: [{ kind: 'home', address_1: '123', address_2: '', address_3: '',
                      city: 'was', county: '', state: 'DC', location_state_code: nil,
                      full_text: nil, zip: '12321', country_name: '', has_fixed_address: true }],
        phones: [], emails: [] }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
    end
  end
end
