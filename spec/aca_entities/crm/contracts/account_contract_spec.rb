# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe AcaEntities::Crm::Contracts::AccountContract do

  let(:email) { 'john.doe@example.com' }

  let(:phone) { '(123) 456-7890' }

  let(:ssn) { '123456789' }

  let(:contact) do
    {
      hbxid_c: '12345',
      first_name: 'John',
      last_name: 'Doe',
      phone_mobile: phone,
      email1: email,
      birthdate: (Date.today - 10_000).to_s,
      relationship_c: 'Spouse'
    }
  end

  let(:required_values) do
    {
      hbxid_c: '12345',
      name: 'John Doe',
      billing_address_street: '123 Main St',
      billing_address_city: 'Anytown',
      billing_address_postalcode: '12345',
      billing_address_state: 'ST',
      raw_ssn_c: ssn,
      dob_c: (Date.today - 10_000).to_s,
      contacts: [contact]
    }
  end

  let(:optional_values) do
    {
      email1: email,
      phone_office: phone,
      billing_address_street2: 'Apt 1',
      billing_address_street3: 'Floor 2',
      billing_address_street4: 'Suite 3',
      rawssn_c: ssn,
      enroll_account_link_c: 'http://example.com/account'
    }
  end

  let(:all_values) { required_values.merge(optional_values) }

  context 'with required values only' do
    it 'passes validation' do
      expect(subject.call(required_values).success?).to be true
    end
  end

  context 'with all values' do
    it 'passes validation' do
      expect(subject.call(all_values).success?).to be true
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

  context 'with invalid email format' do
    let(:email) { 'john.example.com' }

    it 'fails validation' do
      result = subject.call(all_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:email1]).to include('is in invalid format')
    end
  end

  context 'with invalid phone format' do
    let(:phone) { '123-456-7890' }

    it 'fails validation' do
      result = subject.call(all_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:phone_office]).to include('is in invalid format')
    end
  end

  context 'with invalid phone data type' do
    let(:phone) { Date.today }

    it 'fails validation' do
      result = subject.call(all_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:phone_office]).to include('must be a string')
    end
  end

  context 'with invalid SSN format' do
    let(:ssn) { 'my_test_ssn' }

    it 'fails validation' do
      result = subject.call(required_values)
      expect(result.failure?).to be true
      expect(result.errors.to_h[:raw_ssn_c]).to include('is in invalid format')
    end
  end

  context "with blank phone number" do
    let(:phone) { nil }

    it "passes validation" do

      expect(subject.call(all_values).success?).to be true
    end
  end

  context "with blank email" do
    let(:email) { nil }

    it "passes validation" do
      expect(subject.call(all_values).success?).to be true
    end
  end
end
