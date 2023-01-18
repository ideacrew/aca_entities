# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::AcaIndividuals::MonthOfYear, dbclean: :after_each do
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

  let(:months_of_year) do
    {
      month: "January",
      coverage_information: coverage_information
    }
  end

  let(:input_params) do
    months_of_year
  end

  let(:months_of_year_params) do
    AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::MonthOfYearContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(months_of_year_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(months_of_year_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(months_of_year_params.to_h) }.not_to raise_error
    end
  end
end
