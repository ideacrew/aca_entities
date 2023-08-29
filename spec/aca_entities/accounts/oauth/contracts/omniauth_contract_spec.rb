# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::OmniauthContract do
  subject { described_class.new }

  let(:provider) { 'keycloak_openid' }
  let(:uid) { 'george.jetson' }

  let(:name) { 'George Jetson' }
  let(:email) { 'george.jetson@example.com' }
  let(:nickname) { 'Georgy' }
  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }
  let(:location) { 'New Columbia' }
  let(:description) { "George likes cloud surfing and observing Saturn's Rings" }
  let(:image) { 'https://example.com/images/george_jetson.jpeg' }
  let(:phone) { '4105551212' }
  let(:urls) { { blog: 'https://example.com/blogs/george_jetson' } }

  let(:info) { { name: name } }

  let(:token) { '48jdlllejjllklkfkklkdlfkfl' }
  let(:secret) { 'abd837sd989ddlsdlkdflkasd394887j' }
  let(:expires) { true }
  let(:expires_at) { Time.now }

  let(:credentials) do
    {
      token: token,
      secret: secret,
      expires: expires,
      expires_at: expires_at
    }
  end
  let(:extra) { {} }

  let(:required_params) { { provider: provider, uid: uid, info: info } }
  let(:optional_params) { { credentials: credentials, extra: extra } }

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
