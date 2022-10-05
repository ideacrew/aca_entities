# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::TaxHouseholdGroupContract do
  include_context('insurance_policies_context')

  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:tax_household_group_id) { 'th_101' }
  let(:assistance_year) { moment.year }

  let(:members) do
    [
      george_jetson[:enrolled_member][:member],
      jane_jetson[:enrolled_member][:member],
      judy_jetson[:enrolled_member][:member]
    ]
  end
  let(:health_benchmark_plan) { shared_health_insurance_product }
  let(:dental_benchmark_plan) { shared_dental_insurance_product }
  let(:max_aptc_amount) { 450.00 }
  let(:csr_percent) { 83 }
  let(:expected_contribution_amount) { 125.00 }
  let(:premium_credit_monthly_cap) { 1100.00 }
  let(:start_on) { january_1 }
  let(:end_on) { december_31 }

  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      tax_household_group_id: tax_household_group_id,
      assistance_year: assistance_year,
      members: members,
      health_benchmark_plan: health_benchmark_plan,
      max_aptc_amount: max_aptc_amount,
      start_on: start_on
    }
  end

  let(:optional_params) do
    {
      id: id,
      csr_percent: csr_percent,
      expected_contribution_amount: expected_contribution_amount,
      premium_credit_monthly_cap: premium_credit_monthly_cap,
      dental_benchmark_plan: dental_benchmark_plan,
      end_on: end_on,
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
    let(:error_message) do
      {
        tax_household_group_id: ['is missing'],
        assistance_year: ['is missing'],
        members: ['is missing'],
        health_benchmark_plan: ['is missing'],
        max_aptc_amount: ['is missing'],
        start_on: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
