# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::IdentityContract do
  subject { described_class.new }

  # Identity parent class attributes
  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'George Jetson' }
  let(:enabled) { true }

  # OmniauthIdentity class attributes
  let(:provider) { 'keycloak_openid' }
  let(:user_id) { 'george.jetson2022' }
  let(:password) { '$3cr3tP@55w0rd' }

  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }

  let(:email) { 'george.jetson2022@example.com' }
  let(:email_verified) { false }
  let(:enabled) { true }
  let(:access) { { manage_group_membership: true, view: true, map_roles: true, impersonate: false, manage: true } }
  let(:groups) { [] }
  let(:realm_roles) { ['hbx_staff'] }
  let(:client_roles) { ['developer'] }
  let(:profile) { { client_key: 'enroll', settings: { locale: 'en' } } }

  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  let(:required_params) { { name: name, enabled: enabled } }
  let(:optional_params) { { id: id, time_stamp: time_stamp } }

  #   {
  #     id: id,
  #     email: email,
  #     first_name: first_name,
  #     last_name: last_name,
  #     password: password,
  #     enabled: enabled,
  #     email_verified: email_verified,
  #     realm_roles: realm_roles,
  #     client_roles: client_roles,
  #     access: access,
  #     groups: groups,
  #     profile: profile,
  #     attributes: {
  #       relay_state:
  #         'https://enroll.coverme.gov/benefit_sponsors/profiles/registrations/new?portal=true&profile_type=broker_agency'
  #     },
  #     created_at: created_at
  #   }
  # end

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
end
