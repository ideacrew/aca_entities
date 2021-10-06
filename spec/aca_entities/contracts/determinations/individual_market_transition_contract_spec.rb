# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Determinations::IndividualMarketTransitionContract, dbclean: :after_each do

  let!(:required_params) do
    {
      role_type: "consumer",
      start_on: Date.today,
      end_on: Date.today,
      reason_code: "initial_individual_market_transition_created_using_data_migration",
      submitted_at: DateTime.now
    }

  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :role_type })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(submitted_at: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a date time')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(role_type: 'test'))
        expect(result.errors.messages.first.text).to eq('must be one of: consumer, resident')
      end
    end
  end
end
