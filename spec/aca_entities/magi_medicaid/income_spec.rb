# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/types'
require 'aca_entities/magi_medicaid/employer'
require 'aca_entities/magi_medicaid/income'

RSpec.describe ::AcaEntities::MagiMedicaid::Income, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:employer) do
      { employer_name: 'Employer Test', employer_id: '123456789' }
    end

    let(:input_params) do
      { kind: 'wages_and_salaries',
        wage_type: 'wage_type',
        hours_per_week: 40,
        amount: 100.00,
        amount_tax_exempt: 0.0,
        frequency_kind: 'Monthly',
        start_on: Date.today.prev_year,
        end_on: nil,
        is_projected: false,
        employer: employer,
        has_property_usage_rights: false }
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
