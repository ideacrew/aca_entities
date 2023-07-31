# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::Contracts::SbmiEnrolleeContract, dbclean: :after_each do
  let(:required_params) do
    {
      exchange_assigned_memberId: "99921",
      subscriber_indicator: "Y",
      person_last_name: "SMITH",
      birth_date: Date.today.prev_year,
      postal_code: "12345",
      member_start_date: Date.today,
      member_end_date: Date.today,
      gender_code: "M"
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
        @result = subject.call(required_params.reject { |k, _v| k == :birth_date })
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
        @result = subject.call(required_params.merge(birth_date: nil))
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
    end
  end
end