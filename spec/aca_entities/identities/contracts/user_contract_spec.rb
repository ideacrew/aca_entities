# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::UserContract do
  subject { described_class.new }

  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }

  let(:provider) { 'keycloak_openid' }
  let(:name) { 'George Jetson' }
  let(:user_id) { 'george.jetson2022' }

  let(:omniauth_identity) { { provider: provider, user_id: user_id } }
  let(:identity) { omniauth_identity }

  # let(:first_name) { 'George' }
  # let(:last_name) { 'Jetson' }
  let(:person) { { first_name: first_name, last_name: last_name } }

  # let(:email) { 'george.jetson2022@example.com' }
  # let(:email_verified) { false }
  let(:last_portal_visited) { URI('https://example.com/spacely_sprockets') }
  let(:user_profile) { { client_key: 'enroll', settings: { locale: 'en' } } }

  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  let(:required_params) { { identity: omniauth_identity } }

  let(:optional_params) do
    {
      id: id,
      # person: person,
      # email: email,
      # email_verified: email_verified,
      # attestations: attestations,
      last_portal_visited: last_portal_visited,
      user_profile: user_profile,
      time_stamp: time_stamp
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
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
