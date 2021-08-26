# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::MedicaidAndChipContract, dbclean: :around_each do

  let(:all_params) do
    { not_eligible_in_last_90_days: true,
      denied_on: Date.today.next_month,
      ended_as_change_in_eligibility: false,
      hh_income_or_size_changed: false,
      medicaid_or_chip_coverage_end_date: nil,
      ineligible_due_to_immigration_in_last_5_years: false,
      immigration_status_changed_since_ineligibility: false }
  end

  let(:invalid_params) do
    all_params.merge({ denied_on: 'denied_on' })
  end

  context 'with invalid params' do
    context 'bad data type value' do
      it 'should fail validation' do
        result = subject.call(invalid_params)
        expect(result).to be_failure
        expect(result.errors.to_h).to eq({ :denied_on => ['must be a date'] })
      end
    end

    context 'no params' do
      it 'should fail validation' do
        expect(subject.call({}).errors.to_h).to eq({ not_eligible_in_last_90_days: ['is missing'] })
      end
    end
  end

  context 'valid parameters' do
    it 'should pass validation' do
      result = subject.call(all_params)
      expect(result).to be_success
    end
  end
end
