# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/household_income'

RSpec.describe ::AcaEntities::HouseholdIncome do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        monthly_income_greater_than_fpl: true,
        income_type_code: 'CapitalGains',
        income_amount: 500.00,
        income_frequency: 'Weekly',
        income_from_tribal_source: 120.00,
        monthly_attested_medicaid_household_current_income: nil,
        annual_total_project_medicaid_household_current_income: nil
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
