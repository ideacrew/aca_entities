# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsurancePolicyContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:policy_id) { 'policy_101' }
  let(:insurer_policy_id) { 'insurer_id_123' }
  let(:coverage_kind) { 'hmo' }
  let(:insurance_product) { shared_health_insurance_product }
  let(:insurance_provider) { shared_insurance_provider }
  let(:marketplace_segment_id) { '0130345-68576-20220201' }

  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      policy_id: policy_id,
      marketplace_segment_id: marketplace_segment_id,
      coverage_kind: coverage_kind,
      insurance_product: insurance_product,
      insurance_provider: insurance_provider,
      hbx_enrollment_ids: [policy_id],
      enrollments: [enrollment],
      start_on: Date.new(moment.year, 1, 1)
    }
  end
  let(:optional_params) do
    { id: id, insurer_policy_id: insurer_policy_id, timestamps: timestamps,
      term_for_np: true }
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
        policy_id: ['is missing'],
        hbx_enrollment_ids: ['is missing'],
        insurance_product: ['is missing'],
        insurance_provider: ['is missing'],
        start_on: ["is missing"]
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
