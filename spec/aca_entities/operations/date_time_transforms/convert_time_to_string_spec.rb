# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/types'
require 'aca_entities/operations/date_time_transforms/convert_time_to_string'
require 'active_support/time'

RSpec.describe AcaEntities::Operations::DateTimeTransforms::ConvertTimeToString do
  describe '#call' do
    context 'when the input is a valid Time object' do
      let(:input_params) { { time: Time.now } }

      it 'returns a success' do
        result = subject.call(input_params)
        expect(result).to be_success
        expect(result.value!).to be_a(String)
      end
    end

    context 'when the input is valid ActiveSupport::TimeWithZone object' do
      let(:input_params) do
        Time.zone = 'UTC'
        { time: Time.zone.now }
      end

      it 'returns a success' do
        result = subject.call(input_params)
        expect(result).to be_success
        expect(result.value!).to be_a(String)
      end
    end

    context 'when the input is nil' do
      let(:input_params) { nil }

      it 'returns a failure' do
        result = subject.call(input_params)
        expect(result).to be_failure
        expect(result.failure).to eq('Invalid input: params cannot be nil.')
      end
    end

    context 'when the input value for time is nil' do
      let(:input_params) { { time: nil } }

      it 'returns a failure' do
        result = subject.call(input_params)
        expect(result).to be_failure
        expect(result.failure).to eq("Invalid input: #{input_params}. Time is required.")
      end
    end

    context 'when time is not a Time object' do
      let(:input_params) { { time: 'not a time object' } }

      it 'returns a failure' do
        result = subject.call(input_params)
        expect(result).to be_failure
        expect(result.failure).to eq("Invalid input: #{input_params}. Time must be a Time object.")
      end
    end
  end
end
