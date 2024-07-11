# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe AcaEntities::Crm::Contracts::ContactContract do
  let(:email) { 'john.doe@example.com' }

  let(:phone) { '(123) 456-7890' }

  let(:required_values) do
    {
      hbxid_c: '12345',
      first_name: 'John',
      last_name: 'Doe',
      phone_mobile: phone,
      email: email,
      birthdate: (Date.today - 10_000).to_s,
      relationship_c: 'Spouse'
    }
  end

  subject { described_class.new }

  context 'with valid values' do
    it 'passes validation' do
      expect(subject.call(required_values).success?).to be true
    end
  end

  context 'with missing required values' do
    it 'fails validation' do
      required_values.each_key do |key|
        invalid_input = required_values.reject { |k, _| k == key }
        result = subject.call(invalid_input)
        expect(result.failure?).to be true
        expect(result.errors.to_h.keys).to include(key)
      end
    end
  end

  context 'with empty values for required fields' do
    it 'fails validation' do
      invalid_input = required_values.transform_values { '' }
      result = subject.call(invalid_input)
      expect(result.failure?).to be true
      required_values.each_key do |key|
        expect(result.errors.to_h[key]).to include('must be filled')
      end
    end
  end

  context 'with invalid email format' do
    let(:email) { 'john.example.com' }

    it 'fails validation' do
      result = subject.call(required_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:email]).to include('is in invalid format')
    end
  end

  context 'with invalid phone format' do
    let(:phone) { '123-456-7890' }

    it 'fails validation' do
      result = subject.call(required_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:phone_mobile]).to include('is in invalid format')
    end
  end

  context 'with invalid phone data type' do
    let(:phone) { Date.today }

    it 'fails validation' do
      result = subject.call(required_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:phone_mobile]).to include('must be a string')
    end
  end
end
