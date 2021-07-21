# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/tax_household_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::TaxHouseholdContract, dbclean: :after_each do

  let(:required_params) do
    { household_incomes: [household_income] }
  end

  let(:optional_params) do
    {
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
      monthly_income_greater_than_fpl: true,
      income_type_code: 'CapitalGains',
      income_amount: 500.00,
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
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect(subject.call(optional_params).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
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
