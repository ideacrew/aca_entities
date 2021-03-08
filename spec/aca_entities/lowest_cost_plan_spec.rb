# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/lowest_cost_plan'

RSpec.describe ::AcaEntities::LowestCostPlan do

  describe 'with valid arguments' do
    let(:input_params) do
      { employer_lcsop_cost: 100.00,
        coverage_year_code: 'Test',
        employer_offers_mvsp: false,
        employee_do_not_know_mvsp: false }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
