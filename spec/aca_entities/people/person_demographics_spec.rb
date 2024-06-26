# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonDemographics, dbclean: :after_each do

  let!(:input_params) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
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
      expect { described_class.new(input_params.reject { |k, _v| k == :dob }) }.to raise_error(Dry::Struct::Error, /:dob is missing/)
    end
  end

  describe 'alive_status' do
    let(:alive_status) { { is_deceased: false, date_of_death: nil } }

    let(:params) do
      input_params.merge(alive_status: alive_status)
    end

    it 'initializes' do
      expect(described_class.new(params)).to be_a described_class
    end

    it 'does not raise errors' do
      expect { described_class.new(params) }.not_to raise_error
    end
  end
end
