# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Benefit, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:employer) do
      { employer_name: 'Employer Test', employer_id: '123456789' }
    end

    let(:input_params) do
      { kind: 'employer_sponsored_insurance',
        status: 'is_enrolled',
        is_employer_sponsored: true,
        employer: employer,
        esi_covered: 'self_and_spouse',
        is_esi_waiting_period: false,
        is_esi_mec_met: false,
        employee_cost: 1000.00,
        employee_cost_frequency: 'Monthly',
        start_on: Date.today.prev_year,
        end_on: nil }
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
