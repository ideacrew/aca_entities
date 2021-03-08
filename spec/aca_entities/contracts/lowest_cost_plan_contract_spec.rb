# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/lowest_cost_plan_contract'

RSpec.describe AcaEntities::Contracts::LowestCostPlanContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    { employer_lcsop_cost: 100.00,
      coverage_year_code: 'test',
      employer_offers_mvsp: false,
      employee_do_not_know_mvsp: false }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end
end
