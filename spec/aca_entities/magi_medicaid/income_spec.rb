# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Income do

  describe 'with valid arguments' do
    let(:employer) do
      { employer_name: 'Employer Test', employer_id: '123456789' }
    end

    let(:input_params) do
      { kind: 'wages_and_salaries',
        wage_type: 'wage_type',
        hours_per_week: 40,
        amount: 100.00,
        amount_tax_exempt: 0.0,
        frequency_kind: 'Monthly',
        start_on: Date.today.prev_year,
        end_on: nil,
        is_projected: false,
        employer: employer,
        has_property_usage_rights: false,
        ssi_type: 'Disability' }
    end

    before do
      income_params = AcaEntities::MagiMedicaid::Contracts::IncomeContract.new.call(input_params).to_h
      @result = described_class.new(income_params)
    end

    it 'should return income entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of income' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of employer' do
      result_employer_keys = @result.to_h[:employer].keys
      input_employer_keys = employer.keys
      expect(result_employer_keys - input_employer_keys).to be_empty
      expect(input_employer_keys - result_employer_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(kind: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :kind/)
    end
  end
end
