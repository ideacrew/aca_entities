# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::IdentityContract do
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
  let(:realm_roles) { ['hbx_staff'] }
  let(:client_roles) { ['developer'] }
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
      realm_roles: realm_roles,
      client_roles: client_roles,
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

  context 'Calling the contract with only optional params' do
    it 'should fail validation' do
      result = described_class.new.call(optional_params)
      expect(result.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end

  context 'when passed invalid relay state' do
    let(:attributes) { { relay_state: 'https://enroll.coverme.gov/benefit_sponsors/profiles/registrations/new' } }

    it 'should fail' do
      result = described_class.new.call(all_params.merge(attributes: attributes))
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to include(:attributes)
    end
  end

  context 'when passed valid relay state which includes identifier' do
    let(:attributes) do
      {
        relay_state:
          'https://enroll.coverme.gov/benefit_sponsors/profiles/broker_agencies/broker_agency_profiles/%23%5BDouble%20(anonymous)%5D'
      }
    end

    it 'should pass' do
      result = described_class.new.call(all_params.merge(attributes: attributes))
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params.merge(attributes: attributes)
    end
  end

  context 'when passed wrong type for relay state' do
    let(:attributes) { { relay_state: true } }

    it 'should fail' do
      result = described_class.new.call(all_params.merge(attributes: attributes))
      expect(result.errors[:attributes][:relay_state]).to eq ['must be a string']
    end
  end
end
