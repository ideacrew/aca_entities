# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/income_date'
require 'aca_entities/medicaid/atp/income_earned_date_range'
require 'aca_entities/medicaid/atp/income_frequency'
require 'aca_entities/medicaid/atp/income_payment_frequency'
require 'aca_entities/medicaid/atp/income_source_organization_reference'
require 'aca_entities/medicaid/atp/person_income'

RSpec.describe ::AcaEntities::Medicaid::Atp::PersonIncome,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { employment_source_text: "Acme",
        amount: 50_000.00,
        days_per_week: 5,
        hours_per_pay_period: 80.0,
        hours_per_week: 40.0,
        category_code: "Wages",
        description_text: "Robot",
        subject_to_federal_restrictions_indicator: false,
        date: income_date,
        earned_date_range: income_earned_date_range,
        frequency: income_frequency,
        payment_frequency: payment_frequency,
        source_organization_reference: source_organization_reference }
    end

    let(:income_date) do
      start_date
    end

    let(:income_earned_date_range) do
      { start_date: start_date,
        end_date: end_date }
    end

    let(:start_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2020",
        year_month: "12/2020" }
    end

    let(:end_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2021",
        year_month: "12/2021" }
    end

    let(:income_frequency) do
      { frequency_code: "BiWeekly" }
    end

    let(:payment_frequency) do
      { frequency_code: "Weekly" }
    end

    let(:source_organization_reference) do
      { ref: "ref123" }
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

