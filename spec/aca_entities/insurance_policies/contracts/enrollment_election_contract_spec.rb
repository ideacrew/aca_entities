# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::EnrollmentElectionContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:id) { '12345' }

  let(:subscriber) { george_jetson[:enrolled_member] }
  let(:dependents) { [jane_jetson[:enrolled_member], judy_jetson[:enrolled_member]] }
  let(:product_kind) { 'health' }
  let(:product) { shared_health_insurance_product }

  let(:coverage_kind) { 'hmo' }
  let(:coverage_level_kind) { 'silver' }
  let(:coverage_level_basis_kind) { 'in_network_coverage_payment' }

  let(:product_details) do
    {
      coverage_kind: coverage_kind,
      coverage_level_kind: coverage_level_kind,
      coverage_level_basis_kind: coverage_level_basis_kind
    }
  end

  let(:effective_date) { january_1 }
  let(:end_on) { december_31 }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { subscriber: subscriber, product_kind: product_kind, product: product, effective_date: effective_date }
  end
  let(:optional_params) do
    { id: id, dependents: dependents, product_details: product_details, end_on: end_on, timestamps: timestamps }
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
      {
        product: ['is missing'],
        product_kind: ['is missing'],
        subscriber: ['is missing'],
        effective_date: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
