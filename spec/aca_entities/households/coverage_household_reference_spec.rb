# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Households::CoverageHouseholdReference do

  let(:input_params) do
    {
      start_date: Date.today,
      is_immediate_family: false,
      is_determination_split_household: false
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
                              k == :is_immediate_family
                            end)
      end.to raise_error(Dry::Struct::Error, /:is_immediate_family is missing/)
    end
  end
end
