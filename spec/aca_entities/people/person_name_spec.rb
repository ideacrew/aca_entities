# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonName do

  let!(:input_params) do
    {
      first_name: 'first name',
      last_name: 'last name',
      middle_name: 'middle name'
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
      expect { described_class.new(input_params.reject { |k, _v| k == :first_name }) }.to raise_error(Dry::Struct::Error, /:first_name is missing/)
    end
  end
end
