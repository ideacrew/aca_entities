# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/tax_household_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::TaxHouseholdContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      household_incomes: [household_income],
      household_size_change_expected_indicator: false,
      primary_tax_filer: { role_reference: { ref: 'pe123' } },
      spouse_tax_filer: { role_reference: { ref: 'pe123' } },
      tax_dependents:
      [{
        role_reference: { ref: 'pe123' },
        claimed_by_custodial_parent_indicator: true,
        tin_identification: { identification_id: '123' }
      }],
      household_member_references: [{ ref: 'pe123' }],
      household_size_quantity: 2
    }
  end

  let(:household_income) do
    {
      monthly_income_greater_than_fpl: 0.00,
      category_code: 'CapitalGains',
      amount: 500.00,
      income_frequency: { frequency_code: 'Weekly' },
      date: { date: Date.today },
      income_from_tribal_source: 120.00,
      source_organization_reference: { ref: 'em123' },
      monthly_attested_medicaid_household_current_income: 0.00,
      annual_total_project_medicaid_household_current_income: 0.00
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

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
