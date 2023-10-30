# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Account do
  let(:moment) { Time.now }

  let(:id) { 'abc123zxy' }
  let(:name) { 'Stephan Strange' }
  let(:current_sign_in_at) { moment }
  let(:last_sign_in_at) { moment }
  let(:current_sign_in_ip) { '192.168.0.11' }
  let(:last_sign_in_ip) { '192.168.0.11' }
  let(:sign_in_count) { 1 }
  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

  # Identity params
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:identities) { [{ provider: provider, uid: uid }] }

  # Profile params
  let(:preferred_name) { 'John Jacob Jingleheimer-Schmitt' }
  let(:locale) { 'en' }
  let(:notice_delivery_method) { 'electronic_preferred' }
  let(:electronic_communication_method) { 'sms' }

  let(:profile) do
    {
      preferred_name: preferred_name,
      locale: locale,
      notice_delivery_method: notice_delivery_method,
      electronic_communication_method: electronic_communication_method
    }
  end

  let(:required_params) { { name: name, identities: identities } }
  let(:optional_params) do
    {
      id: id,
      profile: profile,
      sign_in_count: sign_in_count,
      current_sign_in_at: current_sign_in_at,
      last_sign_in_at: last_sign_in_at,
      current_sign_in_ip: current_sign_in_ip,
      last_sign_in_ip: last_sign_in_ip,
      created_at: created_at,
      updated_at: updated_at
    }
  end
  let(:nil_value_optional_params) { { id: nil, created_at: nil, updated_at: nil } }
  let(:all_params) { required_params.merge(optional_params) }

  let(:contract_klass) { AcaEntities::Accounts::Contracts::AccountContract }

  describe 'attributes' do
    context 'with required params' do
      subject(:account) { described_class.new(required_params) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq required_params
      end
    end

    context 'with all params' do
      subject(:account) { described_class.new(all_params) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq all_params
      end
    end

    context 'with optional params that have nil values' do
      subject(:account) { described_class.new(all_params.merge(nil_value_optional_params)) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq all_params.merge(nil_value_optional_params)
      end
    end
  end

  describe 'with valid arguments' do
    subject(:account) { described_class.new(required_params) }

    it 'validates input params with contract' do
      expect(contract_klass.new.call(all_params).success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(all_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params.to_h) }.not_to raise_error
    end
  end
end
