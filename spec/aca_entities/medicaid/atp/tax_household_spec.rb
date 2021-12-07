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

  describe 'with valid arguments' do
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

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end

    context 'with only optional parameters' do
      it 'should contain all optional keys and values' do
        result = described_class.new(optional_params)
        expect(result.to_h).to eq optional_params
      end
    end
  end
end