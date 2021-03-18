# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/ssa_work_quarter_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::SsaWorkQuarterContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      { work_year_date: Date.today,
        quarters_earned: 3 }
    end

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

  context 'invalid params' do
    let(:input_params) do
      { work_year_date: 'Test',
        quarters_earned: 3 }
    end

    it 'should return failure with errors' do
      expect(subject.call(input_params).errors.to_h).to eq({ work_year_date: ['must be a date'] })
    end
  end
end
