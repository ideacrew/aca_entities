# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Account do
  subject { described_class.new }

  let(:id) { 'abc123' }
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'Steven Strange' }
  let(:email) { 'my_username@example.com' }
  let(:encrypted_password) { 'abc123xyz' }

  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

  let(:required_params) { { provider: provider, uid: uid, name: name } }
  let(:optional_params) do
    { id: id, email: email, encrypted_password: encrypted_password, created_at: created_at, updated_at: updated_at }
  end
  let(:all_params) { required_params.merge(optional_params) }

  let(:contract_klass) { AcaEntities::Accounts::Contracts::AccountContract }

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
