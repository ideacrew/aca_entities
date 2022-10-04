# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::OmniauthIdentityContract do
  subject { described_class.new }

  # Identity parent class attributes
  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'George Jetson' }
  let(:enabled) { true }
  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  # OmniauthIdentity class attributes
  let(:provider) { 'keycloak_openid' }
  let(:user_id) { 'george.jetson2022' }
  let(:password) { '$3cr3tP@55w0rd' }
  let(:email) { 'george.jetson2022@example.com' }
  let(:email_verified) { false }
  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }
  let(:attributes) do
    {
      relay_state:
        'https://enroll.coverme.gov/benefit_sponsors/profiles/registrations/new?portal=true&profile_type=broker_agency'
    }
  end

  let(:required_params) { { provider: provider, user_id: user_id, name: name, enabled: enabled } }
  let(:optional_params) do
    {
      id: id,
      password: password,
      email: email,
      email_verified: email_verified,
      first_name: first_name,
      last_name: last_name,
      attributes: attributes,
      time_stamp: time_stamp
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
