# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Deduction do

  describe 'with valid arguments' do
    let(:input_params) do
      { kind: 'alimony_paid',
        amount: 1000.00,
        start_on: Date.today.prev_year,
        end_on: nil,
        frequency_kind: 'Monthly' }
    end

    before do
      deduction_params = AcaEntities::MagiMedicaid::Contracts::DeductionContract.new.call(input_params).to_h
      @result = described_class.new(deduction_params)
    end

    it 'should return deduction entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of deduction' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(kind: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :kind/)
    end
  end
end
