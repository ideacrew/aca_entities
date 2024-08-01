# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe ::AcaEntities::Crm::Account do

  let(:email) { 'john.doe@example.com' }

  let(:phone) { '(123) 456-7890' }

  let(:ssn) { '123456789' }

  let(:contact) do
    {
      hbxid_c: '12345',
      first_name: 'John',
      last_name: 'Doe',
      birthdate: (Date.today - 10_000).to_s,
      relationship_c: 'Spouse'
    }
  end

  let(:required_values) do
    {
      hbxid_c: '12345',
      name: 'John Doe',
      dob_c: (Date.today - 10_000).to_s,
      contacts: [contact]
    }
  end

  let(:optional_values) do
    {
      raw_ssn_c: ssn,
      rawssn_c: ssn,
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

  let(:account_params) { required_values.merge(optional_values) }

  describe '.initialize' do
    before do
      app_params_result = AcaEntities::Crm::Contracts::AccountContract.new.call(input_params)
      @result = if app_params_result.failure?
                  app_params_result
                else
                  described_class.new(app_params_result.to_h)
                end
    end

    context 'with both required and optional values' do
      let(:input_params) { account_params }

      it 'should return account entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of account' do
        expect(@result.to_h.keys.sort).to eq(input_params.keys.sort)
      end

      it 'should match all the input keys of contact' do
        result_contact_keys = @result.to_h[:contacts].first.keys
        input_contact_keys = contact.keys
        expect(result_contact_keys - input_contact_keys).to be_empty
        expect(input_contact_keys - result_contact_keys).to be_empty
      end
    end

    context 'with only required values' do
      let(:input_params) { required_values }

      it 'should return account entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of account' do
        expect(@result.to_h.keys.sort).to eq(input_params.keys.sort)
      end

      it 'should match all the input keys of contact' do
        result_contact_keys = @result.to_h[:contacts].first.keys
        input_contact_keys = contact.keys
        expect(result_contact_keys - input_contact_keys).to be_empty
        expect(input_contact_keys - result_contact_keys).to be_empty
      end
    end
  end

  describe '#account_same_as?' do
    let(:account1_params) { account_params }
    let(:account1) { described_class.new(account1_params) }

    let(:account2) { described_class.new(account2_params) }

    context 'with same account' do
      it 'returns true' do
        expect(account1.account_same_as?(account1)).to be_truthy
      end
    end

    context 'with different account' do
      let(:account2_params) { account_params.merge(hbxid_c: '98723') }

      it 'returns false' do
        expect(account1.account_same_as?(account2)).to be_falsey
      end
    end

    context 'when comparing with nil' do
      it 'returns false' do
        expect(account1.account_same_as?(nil)).to be false
      end
    end

    context 'when both accounts has different information for enroll_account_link_c' do
      let(:account2_params) { account_params.merge(enroll_account_link_c: 'kjdhskjh') }

      let(:account1_params) { account_params.merge(enroll_account_link_c: 'test') }

      it 'returns false' do
        expect(account1.account_same_as?(account2)).to be_falsey
      end
    end

    context "with blank emails" do

      let(:email) { nil }

      let(:account_contract) { AcaEntities::Crm::Contracts::AccountContract.new.call(account_params) }

      let(:account_entity) { described_class.new(account_contract.to_h) }

      it "sucessfully passes account contact" do
        expect(account_contract.success?).to be_truthy
      end

      it "returns an account entity object" do
        expect(account_entity).to be_a(described_class)
      end
    end

    context "with blank phones" do

      let(:phone) { nil }

      let(:account_contract) { AcaEntities::Crm::Contracts::AccountContract.new.call(account_params) }

      let(:account_entity) { described_class.new(account_contract.to_h) }

      it "sucessfully passes account contact" do
        expect(account_contract.success?).to be_truthy
      end

      it "returns an account entity object" do
        expect(account_entity).to be_a(described_class)
      end
    end
  end
end
