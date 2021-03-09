# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/ssa_income_information_contract'

RSpec.describe AcaEntities::Contracts::SsaIncomeInformationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    { annual_title_ii_income: 12_000.00,
      monthly_title_ii_income: 100.00,
      title_ii_income_month: Date.today,
      title_ii_income_year: Date.today }
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
