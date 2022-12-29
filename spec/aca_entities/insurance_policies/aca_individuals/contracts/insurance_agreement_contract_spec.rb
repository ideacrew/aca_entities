# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsuranceAgreementContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  context 'CustomerAccount components' do
    let(:id) { '12345' }

    let!(:contract_holder) { george_jetson[:enrolled_member][:member] }
    let(:insurance_provider) { shared_insurance_provider }
    let(:insurance_policies) { [shared_individual_insurance_policy] }
    let(:start_on) { january_1 }
    let(:end_on) { december_31 }
    let(:effectuated_on) { january_2 }

    let(:moment) { DateTime.now }
    let(:timestamps) { { created_at: moment, modified_at: moment } }

    let(:required_params) do
      {
        plan_year: DateTime.now.year,
        contract_holder: contract_holder,
        insurance_provider: insurance_provider,
        insurance_policies: insurance_policies,
        start_on: start_on
      }
    end
    let(:optional_params) { { id: id, end_on: end_on, effectuated_on: effectuated_on, timestamps: timestamps } }
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
          expect(result.to_h).to eq all_params.except(:insurance_product)
        end
      end
    end

    context 'Calling the contract with no params' do
      let(:error_message) do
        {
          contract_holder: ['is missing'],
          insurance_provider: ['is missing'],
          plan_year: ['is missing']
        }
      end
      it 'should pass validation' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
        expect(result.errors.to_h).to eq error_message
      end
    end
  end
end
