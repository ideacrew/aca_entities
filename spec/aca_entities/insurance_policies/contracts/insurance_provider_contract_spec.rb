# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::InsuranceProviderContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:hios_id) { '98765432' }
  let(:title) { 'Red Heart Healthcare' }
  let(:description) { 'Local and National Networks' }
  let(:insurance_products) { [shared_health_insurance_product] }
  let(:insurance_policies) { [shared_individual_insurance_policy] }

  let(:text) { 'Some annotations/notes here' }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { hios_id: hios_id, title: title } }
  let(:optional_params) do
    {
      id: id,
      insurance_products: insurance_products,
      insurance_policies: insurance_policies,
      description: description,
      text: text,
      timestamps: timestamps
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
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
  end

  context 'Calling the contract with no params' do
    let(:error_message) { { hios_id: ['is missing'], title: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
