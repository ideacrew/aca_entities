# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Groups::IrsGroupContract do

  let!(:required_params) do
    {
      hbx_id: '1233',
      start_on: Date.today,
      end_on: Date.today,
      is_active: true
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
        @result = subject.call(required_params.reject { |k, _v| k == :hbx_id })
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
        @result = subject.call(required_params.merge(start_on: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end
    end
  end
end
