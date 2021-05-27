# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::MedicaidAndChip, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { not_eligible_in_last_90_days: true,
        denied_on: Date.today.next_month,
        ended_as_change_in_eligibility: false,
        hh_income_or_size_changed: false,
        medicaid_or_chip_coverage_end_date: nil,
        ineligible_due_to_immigration_in_last_5_years: false,
        immigration_status_changed_since_ineligibility: false }
    end

    before do
      medicaid_cubcare_params = AcaEntities::MagiMedicaid::Contracts::MedicaidAndChipContract.new.call(input_params).to_h
      @result = described_class.new(medicaid_cubcare_params)
    end

    it 'should return MedicaidAndChip entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of MedicaidAndChip' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new }.to raise_error(Dry::Struct::Error, /:not_eligible_in_last_90_days is missing/)
    end
  end
end
