# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/income_earned_date_range'

RSpec.describe ::AcaEntities::Medicaid::Atp::IncomeEarnedDateRange,  dbclean: :around_each do

  describe 'with valid arguments' do

    let(:required_params) { {} }

    let(:optional_params) do
      { end_date: end_date }
    end

    let(:end_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2021",
        year_month: "12/2021" }
    end

    let(:all_params) { required_params.merge(optional_params) }

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end

