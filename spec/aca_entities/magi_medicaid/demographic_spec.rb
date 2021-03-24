# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/demographic'

RSpec.describe ::AcaEntities::MagiMedicaid::Demographic, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { gender: 'Male',
        dob: Date.today.prev_year,
        ethnicity: [] }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
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
