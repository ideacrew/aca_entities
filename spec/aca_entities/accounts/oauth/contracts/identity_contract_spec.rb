# frozen_string_literal: true

require 'spec_helper'
require_relative '../support/shared_examples/keycloak_oidc_examples'

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::IdentityContract do
  subject { described_class.new }
  include_context 'keycloak oidc examples'

  let(:provider) { 'keycloak_openid' }
  let(:uid) { 'george.jetson' }

  let(:nickname) { 'gorgous_george' }
  let(:info) { { nickname: nickname } }
  let(:credentials) { {} }
  let(:extra) { {} }

  let(:required_params) { { provider: provider, uid: uid, info: info } }
  let(:optional_params) { { credentials: credentials, extra: extra } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should fail validation' do
      result = subject.call(optional_params)
      expect(result.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end

  context 'Calling the contract with an example json payload' do
    subject { described_class.new.call(auth_response) }

    let(:info) { auth_response['info'] }
    let(:credentials) { auth_response['credentials'] }
    let(:raw_info) { auth_response['extra']['raw_info'] }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h.deep_symbolize_keys).to eq auth_response.deep_symbolize_keys
    end
  end
end
