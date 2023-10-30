# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Identity do
  let(:id) { 'abc123zxy' }
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

  let(:required_params) { { provider: provider, uid: uid } }
  let(:optional_params) { { id: id, created_at: created_at, updated_at: updated_at } }
  let(:nil_value_optional_params) { { id: nil, created_at: nil, updated_at: nil } }
  let(:all_params) { required_params.merge(optional_params) }

  let(:contract_klass) { AcaEntities::Accounts::Contracts::IdentityContract }

  describe 'attributes' do
    context 'with required params' do
      subject(:identity) { described_class.new(required_params) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq required_params
      end
    end

    context 'with all params' do
      subject(:identity) { described_class.new(all_params) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq all_params
      end
    end

    context 'with optional params that have nil values' do
      subject(:identity) { described_class.new(all_params.merge(nil_value_optional_params)) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq all_params.merge(nil_value_optional_params)
      end
    end
  end

  describe 'with valid arguments' do
    subject(:identity) { described_class.new(required_params) }

    it 'validates input params with contract' do
      expect(contract_klass.new.call(all_params).success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(all_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params.to_h) }.not_to raise_error
    end
  end
end
