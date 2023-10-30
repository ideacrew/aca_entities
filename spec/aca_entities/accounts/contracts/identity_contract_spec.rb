# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::IdentityContract do
  let(:id) { 'abc123zxy' }
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

  let(:required_params) { { provider: provider, uid: uid } }
  let(:optional_params) { { id: id, created_at: created_at, updated_at: updated_at } }
  let(:nil_value_optional_params) { { id: nil, created_at: nil, updated_at: nil } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'attributes' do
    context 'with required params' do
      subject(:identity) { described_class.new.call(required_params) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq required_params
      end

      it 'is valid' do
        expect(identity.success?).to be_truthy
      end
    end

    context 'with all params' do
      subject(:identity) { described_class.new.call(all_params) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq all_params
      end

      it 'is valid' do
        expect(identity.success?).to be_truthy
      end
    end

    context 'with only optional params' do
      subject(:identity) { described_class.new.call(optional_params) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq optional_params
      end

      it 'is not valid' do
        expect(identity.success?).to be_falsey
      end
    end

    context 'with optional params that have nil values' do
      subject(:identity) { described_class.new.call(all_params.merge(nil_value_optional_params)) }

      it 'has the expected attributes' do
        expect(identity.to_h).to eq all_params.merge(nil_value_optional_params)
      end

      it 'is valid' do
        expect(identity.success?).to be_truthy
      end
    end
  end
end
