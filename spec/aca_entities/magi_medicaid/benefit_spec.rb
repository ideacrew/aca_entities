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
        end_on: nil,
        health_plan_meets_mvs_and_affordable: true }
    end

    before do
      benefit_params = AcaEntities::MagiMedicaid::Contracts::BenefitContract.new.call(input_params).to_h
      @result = described_class.new(benefit_params)
    end

    it 'should return benefit entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of benefit' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of employer' do
      result_employer_keys = @result.to_h[:employer].keys
      input_employer_keys = employer.keys
      expect(result_employer_keys - input_employer_keys).to be_empty
      expect(input_employer_keys - result_employer_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(kind: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :kind/)
    end
  end
end
