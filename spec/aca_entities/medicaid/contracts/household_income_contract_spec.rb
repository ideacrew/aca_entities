# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/household_income_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::HouseholdIncomeContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      monthly_income_greater_than_fpl: true,
      income_type: 'CapitalGains',
      income_amount: 500.00,
      income_frequency: 'Weekly',
      income_from_tribal_source: 120.00,
      monthly_attested_medicaid_household_current_income: nil,
      annual_total_project_medicaid_household_current_income: nil
    }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'invalid input for income_type_code' do
      before do
        @result = subject.call(input_params.merge(income_type: 'Test'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to match(/must be one of: CapitalGains, Interest/)
      end
    end

    context 'failure case' do
      before do
        @result = subject.call(input_params.merge(income_frequency: 'DailyMonthly'))
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to match(/must be one of: Weekly, Monthly/)
      end
    end
  end
end
