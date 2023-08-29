# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Keycloak::Account do
  subject { described_class.new }

  let(:id) { '123abc' }
  let(:username) { 'my_username' }
  let(:email) { 'my_username@example.com' }
  let(:first_name) { 'my_first_name' }
  let(:last_name) { 'my_last_name' }
  let(:password) { '$3cr3tP@55w0rd' }

  let(:enabled) { true }
  let(:totp) { true }
  let(:email_verified) { false }
  let(:not_before) { 0 }
  let(:access) { {} }
  let(:groups) { [] }
  let(:roles) { [] }

  let(:created_at) { DateTime.now }

  let(:required_params) { { username: username } }
  let(:optional_params) do
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      enabled: enabled,
      totp: totp,
      email_verified: email_verified,
      not_before: not_before,
      roles: roles,
      access: access,
      groups: groups,
      created_at: created_at,
    }
  end
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(AcaEntities::Accounts::Keycloak::Contracts::AccountContract.new.call(all_params).success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(all_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params.to_h) }.not_to raise_error
    end
  end
end
