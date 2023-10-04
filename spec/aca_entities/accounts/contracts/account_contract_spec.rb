# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::AccountContract do
  let(:id) { 'abc123zxy' }
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'Stephan Strange' }
  let(:email) { 'steven.strange@example.com' }
  let(:encrypted_password) { 'abc123xyz' }
  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

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

  let(:required_params) { { provider: provider, uid: uid, name: name } }
  let(:optional_params) do
    {
      id: id,
      email: email,
      profile: profile,
      encrypted_password: encrypted_password,
      created_at: created_at,
      updated_at: updated_at
    }
  end
  let(:nil_value_optional_params) { { id: nil, email: nil, encrypted_password: nil, created_at: nil, updated_at: nil } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'attributes' do
    context 'with required params' do
      subject(:account) { described_class.new.call(required_params) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq required_params
      end

      it 'is valid' do
        expect(account.success?).to be_truthy
      end
    end

    context 'with all params' do
      subject(:account) { described_class.new.call(all_params) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq all_params
      end

      it 'is valid' do
        expect(account.success?).to be_truthy
      end
    end

    context 'with only optional params' do
      subject(:account) { described_class.new.call(optional_params) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq optional_params
      end

      it 'is not valid' do
        expect(account.success?).to be_falsey
      end
    end

    context 'with optional params that have nil values' do
      subject(:account) { described_class.new.call(all_params.merge(nil_value_optional_params)) }

      it 'has the expected attributes' do
        expect(account.to_h).to eq all_params.merge(nil_value_optional_params)
      end

      it 'is valid' do
        expect(account.success?).to be_truthy
      end
    end
  end
end
