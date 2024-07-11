# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe ::AcaEntities::Crm::Account do

  let(:email) { 'john.doe@example.com' }

  let(:phone) { '(123) 456-7890' }

  let(:ssn) { '123-45-6789' }

  let(:contact) do
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

  let(:required_values) do
    {
      hbxid_c: '12345',
      name: 'John Doe',
      email1: email,
      billing_address_street: '123 Main St',
      billing_address_city: 'Anytown',
      billing_address_postalcode: '12345',
      billing_address_state: 'ST',
      phone_office: phone,
      raw_ssn_c: ssn,
      dob_c: (Date.today - 10_000).to_s,
      contacts: [contact]
    }
  end

  let(:optional_values) { { enroll_account_link_c: 'http://example.com/account' } }

  let(:account_params) { required_values.merge(optional_values) }

  context 'with all valid values' do
    before do
      app_params_result = AcaEntities::Crm::Contracts::AccountContract.new.call(account_params)
      @result = if app_params_result.failure?
                  app_params_result
                else
                  described_class.new(app_params_result.to_h)
                end
    end

    it 'should return account entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of account' do
      expect(@result.to_h.keys.sort).to eq(account_params.keys.sort)
    end

    it 'should match all the input keys of contact' do
      result_contact_keys = @result.to_h[:contacts].first.keys
      input_contact_keys = contact.keys
      expect(result_contact_keys - input_contact_keys).to be_empty
      expect(input_contact_keys - result_contact_keys).to be_empty
    end
  end
end
