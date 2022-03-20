# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Organizations::Contracts::TenantContract do
  let(:key) { :enterprise_key }
  let(:owner_organization_name) { 'owner_organization_name attribute value' }
  let(:owner_account) { 'owner_account attribute value' }

  let(:required_params) { { key: key, owner_account: owner_account } }
  let(:optional_params) { { owner_organization_name: owner_organization_name } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'Entity parameters' do
    context 'with invalid parameters' do
      let(:error_hash) { {} }

      # it { expect(subject.call({}).success?).to be_falsey }
      # it { expect(subject.call({}).errors.messages).to eq error_hash }

      # it { expect(subject.call(optional_params).success?).to be_falsey }
      # it do
      #   expect(subject.call(optional_params).errors.messages).to eq error_hash
      # end
    end

    context 'with required params' do
      # it { expect(subject.call(required_params).success?).to be_truthy }
      # it { expect(subject.call(required_params).errors.messages).to eq [] }
    end

    context 'with all params' do
      # it { expect(subject.call(all_params).success?).to be_truthy }
      # it { expect(subject.call(all_params).errors.messages).to eq [] }
    end

    describe 'Tenant parameters' do
      let(:nested_tenants) do
        { tenants: [{ key: :tenant_key_1 }, { key: :tenant_key_2 }] }
      end

      context 'with no Enterprise and only Tenants params' do
        # it { expect(subject.call(nested_tenants).success?).to be_truthy }
        # it { expect(subject.call(nested_tenants).errors.messages).to eq [] }
      end

      context 'with all Enterprise params and valid nested Tenant params' do
        let(:all_params_and_nested_tenants) { all_params.merge(nested_tenants) }

        # it do
        #   expect(
        #     subject.call(all_params_and_nested_tenants).success?
        #   ).to be_truthy
        # end
        # it do
        #   expect(
        #     subject.call(all_params_and_nested_tenants).errors.messages
        #   ).to eq []
        # end
        # it do
        #   expect(
        #     subject.call(all_params_and_nested_tenants).to_h
        #   ).to eq all_params_and_nested_tenants
        # end
      end

      context 'with all Enterprise params and invalid nested Tenant params' do
        let(:nested_invalid_tenants) do
          { tenants: [{ owner_account: 'mary@example.com' }] }
        end
        let(:all_params_and_nested_invalid_tenants) do
          all_params.merge(nested_invalid_tenants)
        end

        let(:error_key) { :tenants }
        let(:error_message) { { key: ['is missing'] } }

        it 'shouild fail validation' do
          # result = subject.call(all_params_and_nested_invalid_tenants)
          # expect(result.failure?).to be_truthy
          # expect(result.errors.to_h.keys).to eq [error_key]
          # expect(
          #   result.errors.to_h[error_key].values.flatten.first[:error]
          # ).to eq error_message
        end
      end
    end
  end
end
