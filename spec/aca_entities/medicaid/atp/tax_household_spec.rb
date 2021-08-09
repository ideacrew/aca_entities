# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/tin_identification'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/income_source_organization_reference'
require 'aca_entities/medicaid/atp/primary_tax_filer'
require 'aca_entities/medicaid/atp/spouse_tax_filer'
require 'aca_entities/medicaid/atp/income_frequency'
require 'aca_entities/medicaid/atp/income_payment_frequency'
require 'aca_entities/medicaid/atp/tax_dependent'
require 'aca_entities/medicaid/atp/household_member_reference'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/income_earned_date_range'
require 'aca_entities/medicaid/atp/income_date'
require 'aca_entities/medicaid/atp/household_income'
require 'aca_entities/medicaid/atp/tax_household'

RSpec.describe ::AcaEntities::Medicaid::Atp::TaxHousehold,  dbclean: :around_each do

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
      monthly_income_greater_than_fpl: 0.00,
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
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:household_incomes is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:household_incomes is missing in Hash input/)
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end

    context 'with all required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end
  end
end