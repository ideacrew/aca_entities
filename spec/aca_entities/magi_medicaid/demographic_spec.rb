# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Demographic do

  describe 'with valid arguments' do
    let(:input_params) do
      { gender: 'Male',
        dob: Date.today.prev_year,
        ethnicity: [] }
    end

    before do
      demographic_params = AcaEntities::MagiMedicaid::Contracts::DemographicContract.new.call(input_params).to_h
      @result = described_class.new(demographic_params)
    end

    it 'should return demographic entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of demographic' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    context 'no params' do
      it 'should raise error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:gender is missing/)
      end
    end

    context 'invalid data for ethnicity' do
      let(:invalid_params) do
        { gender: 'Male',
          dob: Date.today.prev_year,
          ethnicity: nil }
      end

      it 'should raise error' do
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /invalid type for :ethnicity violates constraints/)
      end
    end

    context 'invalid data for gender' do
      let(:invalid_params) do
        { gender: 'Test',
          dob: Date.today.prev_year }
      end

      it 'should raise error' do
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /invalid type for :gender violates constraints/)
      end
    end
  end
end
