# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/contracts/income_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::IncomeContract do
  let(:required_params) do
    { amount: 300,
      taxable_interest: 30,
      tax_exempt_interest: 0,
      taxable_refunds: 1,
      alimony: 0,
      capital_gain_or_loss: 0,
      pensions_and_annuities_taxable_amount: 0,
      farm_income_or_loss: 0,
      unemployment_compensation: 0,
      other_income: 0,
      magi_deductions: 0,
      adjusted_gross_income: 300,
      deductible_part_of_self_employment_tax: 0,
      ira_deduction: 1,
      student_loan_interest_deduction: 9,
      tution_and_fees: 10,
      other_magi_eligible_income: 0 }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      it 'should list error for every required parameter' do
        result = subject.call({})
        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
