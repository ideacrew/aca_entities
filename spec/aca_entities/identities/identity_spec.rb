# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Identity do
  subject { described_class.new }

  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:provider) { 'keycloak_openid' }
  let(:user_id) { 'george.jetson2022' }
  let(:name) { 'George Jetson' }
  let(:email) { 'george.jetson2022@example.com' }
  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }
  let(:password) { '$3cr3tP@55w0rd' }

  let(:enabled) { true }
  let(:email_verified) { false }
  let(:access) { { manage_group_membership: true, view: true, map_roles: true, impersonate: false, manage: true } }
  let(:groups) { [] }
  let(:roles) { [] }
  let(:profile) { { client_key: 'enroll', settings: { locale: 'en' } } }

  let(:created_at) { DateTime.now }

  let(:required_params) { { provider: provider, user_id: user_id, name: name } }
  let(:optional_params) do
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      enabled: enabled,
      email_verified: email_verified,
      roles: roles,
      access: access,
      groups: groups,
      profile: profile,
      attributes: {
        relay_state:
          'https://enroll.coverme.gov/benefit_sponsors/profiles/registrations/new?portal=true&profile_type=broker_agency'
      },
      created_at: created_at
    }
  end
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(AcaEntities::Accounts::Contracts::AccountContract.new.call(all_params).success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(all_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params.to_h) }.not_to raise_error
    end
  end
end
