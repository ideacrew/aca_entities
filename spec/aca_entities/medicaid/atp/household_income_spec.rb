# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/household_income'

RSpec.describe ::AcaEntities::Medicaid::Atp::HouseholdIncome do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        monthly_income_greater_than_fpl: 0.00,
        income_type_code: 'CapitalGains',
        amount: 500.00,
        income_frequency: { frequency_code: 'Weekly' },
        income_from_tribal_source: 120.00,
        monthly_attested_medicaid_household_current_income: nil,
        annual_total_project_medicaid_household_current_income: nil
      }
    end

    let(:all_params) { required_params.merge(optional_params)}

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
