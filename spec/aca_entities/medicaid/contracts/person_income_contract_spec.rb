# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_income_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::PersonIncomeContract do

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
