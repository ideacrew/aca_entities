# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Omniauth::Contracts::CredentialsContract do
  subject { described_class.new }

  let(:token) { 'aes' }
  let(:secret) { 'Penny wise and pound foolish' }
  let(:expires) { true }
  let(:expires_at) { Time.now }

  let(:required_params) { {} }
  let(:optional_params) { { token: token, secret: secret, expires: expires, expires_at: expires_at } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params only' do
    it 'should pass validation' do
      result = described_class.new.call(optional_params)
      expect(result.success?).to be_truthy
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
