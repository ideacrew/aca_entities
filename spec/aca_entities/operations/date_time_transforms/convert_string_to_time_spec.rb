# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/types'
require 'aca_entities/operations/date_time_transforms/convert_string_to_time'

RSpec.describe AcaEntities::Operations::DateTimeTransforms::ConvertStringToTime do
  subject { described_class.new }

  describe '#call' do
    context 'when params is nil' do
      let(:params) { nil }

      it 'returns a failure' do
        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to eq('Invalid input: params cannot be nil.')
      end
    end

    context 'when time_string is nil' do
      let(:params) { { time_string: nil } }

      it 'returns a failure' do
        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to eq("Invalid input: #{params}. Time string is required.")
      end
    end

    context 'when time_string is not a String' do
      let(:params) { { time_string: 12_345 } }

      it 'returns a failure' do
        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to eq("Invalid input: #{params}. Time string must be a String.")
      end
    end

    context 'when time_string is a valid ISO8601 string' do
      let(:params) { { time_string: '2024-10-14T17:28:44.106928000+0000' } }

      it 'returns a success' do
        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(Time)
      end
    end

    context 'when time_string is an invalid ISO8601 string' do
      let(:params) { { time_string: 'invalid-time-string' } }

      it 'returns a failure' do
        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to include(
          "with time input: #{params[:time_string]}. Time string must match the format #{AcaEntities::Types::DATETIME_FORMAT_ISO8601}."
        )
      end
    end
  end
end
