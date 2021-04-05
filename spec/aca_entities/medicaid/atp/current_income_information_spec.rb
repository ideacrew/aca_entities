# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/current_income_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::CurrentIncomeInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { income_type_code: 'CapitalGains',
        income_type_amount: 100.00,
        income_frequency_code: 'Weekly',
        days_per_week: 5,
        hours_per_week: 30,
        is_income_subject_to_federal_restrictions: false,
        employer_name: 'employer_name',
        employer_ein: '123456789',
        type_of_work: 'type_of_work',
        unemployment_source: 'unemployment_source',
        date_unemployment_ends: Date.today.next_year }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
