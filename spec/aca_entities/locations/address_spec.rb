# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Locations::Address, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        has_fixed_address: true,
        kind: 'home',
        address_1: '123',
        address_2: '',
        address_3: '',
        city: 'was',
        county: '',
        country_code: '',
        state: 'DC',
        zip: '12321',
        country_name: '',
        validation_status: nil,
        start_on: nil,
        end_on: nil,
        lives_outside_state_temporarily: false
      }
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
      expect { subject }.to raise_error(Dry::Struct::Error, /:kind is missing in Hash input/)
    end
  end
end
