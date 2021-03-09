# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ssa_income_information'

RSpec.describe ::AcaEntities::SsaIncomeInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { annual_title_ii_income: 12_000.00,
        monthly_title_ii_income: 100.00,
        title_ii_income_month: Date.today,
        title_ii_income_year: Date.today }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
