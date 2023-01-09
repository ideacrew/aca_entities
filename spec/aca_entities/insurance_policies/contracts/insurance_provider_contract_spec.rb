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

  let(:text) { 'Some annotations/notes here' }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { hios_id: hios_id, title: title, fein: "12345", insurance_products: insurance_products } }
  let(:optional_params) do
    { id: id, description: description, text: text, timestamps: timestamps }
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
    let(:error_message) do
      { hios_id: ['is missing'], title: ['is missing'], fein: ['is missing'],
        insurance_products: ['is missing'] }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
