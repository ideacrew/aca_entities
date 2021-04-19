# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodContract, dbclean: :after_each do

  let(:timestamp) do
    {
      submitted_at: Date.today,
      created_at: Date.today,
      modified_at: Date.today
    }
  end

  let(:qualifying_life_event_kind_reference) do
    {
      start_on: Date.today,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
    }
  end

  let(:required_params) do
    {
      qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
      qle_on: Date.today,
      is_valid: nil,
      effective_on_kind: "first_of_next_month",
      effective_on: Date.today,
      submitted_at: Date.today,
      title: "Lost or will soon lose other health insurance ",
      start_on: Date.today,
      end_on: Date.today,
      qle_answer: nil,
      optional_effective_on: [],
      csl_num: nil,
      market_kind: nil,
      admin_flag: nil
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
        @result = subject.call(required_params.reject { |k, _v| k == :qualifying_life_event_kind_reference })
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
        @result = subject.call(required_params.merge(csl_num: '123'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('length must be within 5 - 10')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(qle_on: nil))
        expect(result.errors.messages.first.text).to eq('must be a date')
      end
    end
  end
end
