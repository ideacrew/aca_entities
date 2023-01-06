# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:name) { 'Insurer Coverall Health Product' }
  let(:insurance_product_features) { [shared_health_insurance_product_feature] }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { name: name, hios_plan_id: "123ME2345",
      plan_year: DateTime.now.year, coverage_type: "dental",
      metal_level: "bronze", market_type: "Individual", ehb: 0.93 }
  end
  let(:optional_params) { { id: id, insurance_product_features: insurance_product_features, timestamps: timestamps } }

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
      { name: ['is missing'],  coverage_type: ['is missing'], ehb: ['is missing'],
        hios_plan_id: ['is missing'], market_type: ['is missing'], metal_level: ['is missing'],
        plan_year: ['is missing'] }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
