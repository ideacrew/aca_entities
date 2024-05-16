# frozen_string_literal: true

require 'spec_helper'
require_relative "../support/shared_examples/keycloak_oidc_examples"

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::InfoContract do
  subject { described_class.new }
  include_context 'keycloak oidc examples'

  let(:name) { 'George Jetson' }
  let(:nickname) { 'gorgous_george' }
  let(:email) { 'george.jetson@example.com' }
  let(:email_verified) { true }
  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }
  let(:gender) { nil }
  let(:location) { 'New Columbia' }
  let(:description) { "George likes cloud surfing and monitoring Saturn's Rings" }
  let(:image) { 'https://example.com/images/george_jetson.jpeg' }
  let(:phone) { '4105551212' }
  let(:urls) { { website: 'https://example.com/blogs/george_jetson' } }

  let(:required_params) { { nickname: nickname } }
  let(:optional_params) do
    {
      name: name,
      email: email,
      email_verified: email_verified,
      first_name: first_name,
      last_name: last_name,
      gender: gender,
      location: location,
      description: description,
      image: image,
      phone: phone,
      urls: urls
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
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
      expect(subject.to_h).to eq all_params.deep_symbolize_keys
    end
  end

  context 'Calling the contract with an example json payload' do
    subject { described_class.new.call(info) }
    let(:info) { auth_response['info'] }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq info.deep_symbolize_keys
    end
  end
end
