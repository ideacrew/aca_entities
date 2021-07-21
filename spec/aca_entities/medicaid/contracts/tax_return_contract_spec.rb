# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/tax_return_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::TaxReturnContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      total_exemptions_quantity: 1,
      status_code: "0",
      tax_return_year: 2020,
      tax_household: tax_household,
      tax_return_includes_dependent_indicator: true
    }
  end

  let(:tax_household) do
    {
      household_incomes:
      [{
        monthly_income_greater_than_fpl: true,
        income_type_code: 'CapitalGains',
        income_amount: 500.00,
        income_frequency: 'Weekly',
        income_from_tribal_source: 120.00,
        monthly_attested_medicaid_household_current_income: 0.00,
        annual_total_project_medicaid_household_current_income: 0.00
      }]
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
