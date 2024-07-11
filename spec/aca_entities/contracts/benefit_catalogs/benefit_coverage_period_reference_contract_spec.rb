# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::BenefitCatalogs::BenefitCoveragePeriodReferenceContract do

  let(:required_params) do
    {
      title: 'test title',
      market_place: 'individual',
      start_on: Date.today,
      end_on: Date.today,
      open_enrollment_start_on: Date.today,
      open_enrollment_end_on: Date.today
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
        @result = subject.call(required_params.reject { |k, _v| k == :title })
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
        @result = subject.call(required_params.merge(title: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be filled')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(market_place: "test"))
        expect(result.errors.messages.first.text).to eq('must be one of: shop, individual, coverall')
      end
    end
  end
end
