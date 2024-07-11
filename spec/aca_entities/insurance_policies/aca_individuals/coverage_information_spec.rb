# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::AcaIndividuals::CoverageInformation do
  include_context('insurance_policies_context')

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

  let(:input_params) do
    coverage_information
  end

  let(:coverage_information_params) do
    AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::CoverageInformationContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(coverage_information_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(coverage_information_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(coverage_information_params.to_h) }.not_to raise_error
    end
  end
end
