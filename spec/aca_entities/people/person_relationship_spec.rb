# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonRelationship do

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

  let!(:input_params) do
    {
      kind: 'child',
      relative: person_reference
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
      expect { described_class.new(input_params.reject { |k, _v| k == :relative }) }.to raise_error(Dry::Struct::Error, /:relative is missing/)
    end
  end
end
