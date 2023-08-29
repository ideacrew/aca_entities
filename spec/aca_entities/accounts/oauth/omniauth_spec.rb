# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Omniauth do

  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }

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

  let(:info) do
    {
      name: name,
      email: email,
      nickname: nickname,
      first_name: first_name,
      last_name: last_name,
      location: location,
      description: description,
      image: image,
      phone: phone,
      urls: urls
    }
  end

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

  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  let(:required_params) { { provider: provider, uid: uid, info: info } }
  let(:optional_params) { { credentials: credentials, time_stamp: time_stamp } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    subject { described_class.call(optional_params) }

    it 'should fail validation' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.call(required_params) }

    it 'should pass validation' do
      expect(subject).to be_a AcaEntities::Accounts::Oauth::Omniauth
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.call(all_params) }

    it 'should pass validation' do
      expect(subject).to be_a AcaEntities::Accounts::Oauth::Omniauth
      expect(subject.to_h).to eq all_params
    end
  end
end
