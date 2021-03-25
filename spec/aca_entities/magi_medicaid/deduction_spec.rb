# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/types'
require 'aca_entities/magi_medicaid/deduction'

RSpec.describe ::AcaEntities::MagiMedicaid::Deduction, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { kind: 'alimony_paid',
        amount: 1000.00,
        start_on: Date.today.prev_year,
        end_on: nil,
        frequency_kind: 'Monthly' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(kind: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :kind/)
    end
  end
end
