# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/current_deduction_information_contract'
require 'aca_entities/types'

RSpec.describe ::AcaEntities::Contracts::CurrentDeductionInformationContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { category_code: 'Alimony',
      amount: 100.00,
      frequency_code: 'Weekly',
      category_text: 'Alimony' }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      before do
        @result = subject.call(all_params.merge({ frequency_code: nil }))
      end

      it 'should return a failure with error message' do
        expect(@result.errors.to_h).to eq({ frequency_code: ['FrequencyCode is expected when Amount is not nil'] })
      end
    end
  end

  context 'valid parameters' do
    before do
      @result = subject.call(all_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should return entity with all params' do
      expect(@result.to_h).to eq all_params
    end
  end
end
