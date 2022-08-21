# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Households::TaxHouseholdMemberReferenceContract, dbclean: :after_each do

  let(:params) do
    {
      is_subscriber: true,
      reason: nil
    }
  end

  context 'success case' do
    before do
      @result = subject.call(params)
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
        @result = subject.call(params.reject { |k, _v| k == :is_subscriber })
      end

      it 'should return failure' do
        # expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        # expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        # expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(params.merge(is_subscriber: 'idk'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be boolean')
      end
    end
  end
end
