# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::MonthOfYearContract do
  subject { described_class.new }

  let(:currency) do
    {
      cents: 98_700.0,
      currency_iso: "USD"
    }
  end

  let(:coverage_information) do
    {
      tax_credit: currency,
      total_premium: currency,
      slcsp_benchmark_premium: currency
    }
  end

  let(:required_params) do
    {
      month: "January",
      coverage_information: coverage_information
    }
  end

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        month: ['is missing'],
        coverage_information: ['is missing']
      }
    end
    it 'should fail validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
