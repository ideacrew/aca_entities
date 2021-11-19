# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/household_income_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::HouseholdIncomeContract, type: :model do

  # it 'should be a container-ready operation' do
  #   expect(subject.respond_to?(:call)).to be_truthy
  # end

  let(:required_params) { {} }

  let(:optional_params) do
    {
      monthly_income_greater_than_fpl: 0.00,
      category_code: 'CapitalGains',
      amount: 500.00,
      income_frequency: { frequency_code: 'Weekly' },
      income_from_tribal_source: 120.00,
      monthly_attested_medicaid_household_current_income: nil,
      annual_total_project_medicaid_household_current_income: nil
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with unexpected parameters' do

      let(:input_params) { { cat: "meow" } }

      it { expect(subject.call(input_params)[:result]).to eq(nil) }
    end
  end

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do

        result = subject.call(all_params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
