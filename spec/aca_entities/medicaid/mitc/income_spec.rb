# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/income'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Income do
  describe 'with valid arguments' do
    let(:input_params) do
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

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Medicaid::Mitc::Income
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
