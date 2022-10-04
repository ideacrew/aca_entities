# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Omniauth::Contracts::AuthContract do
  subject { described_class.new }

  let(:provider) { 'keycloak_openid' }
  let(:uid) { 'george.jetson' }
  let(:name) { 'George Jetson' }
  let(:info) { { name: name } }
  let(:credentials) { {} }
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
