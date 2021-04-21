# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Income do
  describe 'with valid arguments' do
    let(:income) do
      { amount: 100,
        taxable_interest: 30,
        tax_exempt_interest: 0,
        taxable_refunds: 3,
        alimony: 0,
        capital_gain_or_loss: 0,
        pensions_and_annuities_taxable_amount: 0,
        farm_income_or_loss: 0,
        unemployment_compensation: 0,
        other_income: 1,
        magi_deductions: 0,
        adjusted_gross_income: 1,
        deductible_part_of_self_employment_tax: 0,
        ira_deduction: 5,
        student_loan_interest_deduction: 0,
        tution_and_fees: 0,
        other_magi_eligible_income: 0 }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::IncomeContract.new.call(income).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return income entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of income' do
      expect(@result.to_h.keys).to eq(income.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
