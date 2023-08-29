# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::AccountContract do
  let(:id) { 'abc123' }
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'Stephan Strange' }
  let(:email) { 'steven.strange@example.com' }

  let(:created_at) { DateTime.now }

  let(:required_params) { { provider: provider, uid: uid, name: name, email: email } }
  let(:optional_params) { { id: id, email: email } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    subject(:account) { described_class.new.call(optional_params) }

    it 'fails validation' do
      expect(subject.success?).to be_falsey
    end
  end

  context 'Calling the contract with only required params' do
    subject(:account) { described_class.new.call(required_params) }

    it 'passes validation' do
      expect(account.success?).to be_truthy
    end

    it 'populates model with required params' do
      expect(account.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject(:account) { described_class.new.call(all_params) }

    it 'passes validation' do
      expect(account.success?).to be_truthy
    end

    it 'populates model with all params' do
      expect(account.to_h).to eq all_params
    end
  end
end
