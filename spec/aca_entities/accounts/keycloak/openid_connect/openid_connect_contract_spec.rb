# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Keycloak::OpenidConnect::Contracts::OpenidConnectContract do
  subject { described_class.new }

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

  let(:token) { '48jdlllejjllklkfkklkdlfkfl' }
  let(:secret) { 'abd837sd989ddlsdlkdflkasd394887j' }
  let(:expires) { true }
  let(:expires_at) { Time.now }

  let(:provider) { 'openid_connect' }
  let(:uid) { '8323557f-4430-4a9a-81e9-da3aab221ede' }
  let(:info) { { nickname: nickname, email: email } }
  let(:credentials) do
    {
      id_token: id_token,
      token: token,
      refresh_token: refresh_token,
      secret: secret,
      scope: scope,
      expires_in: expires_in
    }
  end
  let(:extra) { {} }

  let(:required_params) { { provider: provider, uid: uid, info: info } }
  let(:optional_params) { { credentials: credentials, extra: extra } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    subject { described_class.new.call(optional_params) }

    it 'should fail validation' do
      expect(subject.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.new.call(required_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.new.call(all_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq all_params
    end
  end
end
