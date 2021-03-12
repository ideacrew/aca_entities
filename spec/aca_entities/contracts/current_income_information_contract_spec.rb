# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/current_income_information_contract'

RSpec.describe ::AcaEntities::Contracts::CurrentIncomeInformationContract, dbclean: :after_each do

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

  context 'with all parameters' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should return all the params' do
      expect(@result.to_h).to eq input_params
    end
  end
end
