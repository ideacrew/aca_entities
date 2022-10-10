# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::IrsGroupContract do
  include_context('insurance_policies_context')

  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:irs_group_id) { 'irs_101' }
  let(:insurance_agreements) { [shared_insurance_agreement] }
  let(:start_on) { january_1 }
  let(:end_on) { december_31 }

  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { irs_group_id: irs_group_id, insurance_agreements: insurance_agreements, start_on: start_on }
  end
  let(:optional_params) { { id: id, end_on: end_on, timestamps: timestamps } }

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
      { irs_group_id: ['is missing'], insurance_agreements: ['is missing'], start_on: ['is missing'] }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
