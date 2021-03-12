# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/current_income_employer_contract'

RSpec.describe ::AcaEntities::Contracts::CurrentIncomeEmployerContract, dbclean: :after_each do

  let(:input_params) do
    { street_1: 'street_1',
      street_2: 'street_2',
      city: 'city',
      state_code: 'DC',
      zip_code: '20001' }
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

  context 'invalid params' do
    before do
      @result = subject.call(input_params.merge({ state_code: 'test' }))
    end

    it 'should return failure' do
      expect(@result.failure?).to be_truthy
    end

    it 'should return failure with error message' do
      expect(@result.errors.to_h[:state_code].first).to match(/must be one of: AL, AK, AS/)
    end
  end
end
