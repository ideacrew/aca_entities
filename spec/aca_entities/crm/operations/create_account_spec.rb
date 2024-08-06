# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe AcaEntities::Crm::Operations::CreateAccount do
  subject { described_class.new }

  let(:first_name) { 'John' }
  let(:last_name) { 'Doe' }
  let(:relationship) { 'Spouse' }
  let(:name) { "#{first_name} #{last_name}" }
  let(:email) { 'john.doe@example.com' }
  let(:phone) { '(123) 456-7890' }

  let(:contact_required_params) do
    {
      hbxid_c: '12345',
      first_name: first_name,
      last_name: last_name,
      birthdate: (Date.today - 10_000).to_s,
      relationship_c: relationship
    }
  end

  let(:contact_optional_params) { { phone_mobile: phone, email1: email } }

  let(:contact) { contact_required_params.merge(contact_optional_params) }

  let(:account_required_params) do
    {
      hbxid_c: '12345',
      name: name,
      dob_c: (Date.today - 10_000).to_s,
      contacts: [contact]
    }
  end

  let(:account_optional_params) do
    {
      raw_ssn_c: '123456789',
      rawssn_c: '123456789',
      phone_office: phone,
      email1: email,
      billing_address_street: '123 Main St',
      billing_address_city: 'Anytown',
      billing_address_postalcode: '12345',
      billing_address_state: 'ST',
      billing_address_street2: 'Apt 1',
      billing_address_street3: 'Floor 2',
      billing_address_street4: 'Suite 3',
      enroll_account_link_c: 'http://example.com/account'
    }
  end

  let(:account) { account_required_params.merge(account_optional_params) }

  let(:input_params) { account }

  let(:result) { subject.call(input_params) }

  describe '#call' do
    context 'with both required and optional values' do
      context 'with valid input' do
        it 'succeeds' do
          expect(result).to be_success
          expect(result.value!).to be_a(AcaEntities::Crm::Account)
        end
      end
    end

    context 'with required values only' do
      let(:contact) { contact_required_params }
      let(:account) { account_required_params }

      it 'succeeds' do
        expect(result).to be_success
        expect(result.value!).to be_a(AcaEntities::Crm::Account)
      end
    end

    context 'with invalid input' do
      let(:first_name) { '' }
      let(:last_name) { '' }
      let(:relationship) { '' }
      let(:name) { '' }

      let(:failure_result) do
        {
          name: ['must be filled'],
          contacts: {
            0 => {
              first_name: ['must be filled'],
              last_name: ['must be filled'],
              relationship_c: ['must be filled']
            }
          }
        }
      end

      it 'fails' do
        expect(result).to be_failure
        expect(result.failure).to eq(failure_result)
      end
    end
  end
end
