# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::ProductEligibilityDetermination, dbclean: :after_each do
  let(:input_params) do
    { is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_non_magi_medicaid_eligible: false,
      is_totally_ineligible: false,
      is_without_assistance: false,
      is_magi_medicaid: false,
      magi_medicaid_monthly_household_income: 6474.42,
      medicaid_household_size: 1,
      magi_medicaid_monthly_income_limit: 3760.67,
      magi_as_percentage_of_fpl: 10.0,
      magi_medicaid_category: 'parent_caretaker',
      magi_medicaid_ineligibility_reasons: ['dummy reason'] }
  end

  describe 'with valid arguments' do
    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(input_params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return ProductEligibilityDetermination entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of ProductEligibilityDetermination' do
      result_app_keys = @result.to_h.keys
      input_app_keys = input_params.keys
      expect(result_app_keys - input_app_keys).to be_empty
      expect(input_app_keys - result_app_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(is_ia_eligible: 'Test') }.to raise_error(Dry::Struct::Error, /has invalid type for :is_ia_eligible/)
    end
  end

  describe '#medicaid_cd_for_citizen_or_immigrant' do
    let(:category_determinations) do
      [{ category: 'Medicaid Citizen Or Immigrant',
         indicator_code: false,
         ineligibility_code: 123,
         ineligibility_reason: 'Applicant did not meet citizenship/immigration requirements' }]
    end

    let(:params) do
      input_params.merge({ category_determinations: category_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return valid category determination' do
      expect(@result.medicaid_cd_for_citizen_or_immigrant).to be_truthy
    end
  end

  describe '#chip_cd_for_citizen_or_immigrant' do
    let(:category_determinations) do
      [{ category: 'CHIP Citizen Or Immigrant',
         indicator_code: false,
         ineligibility_code: 123,
         ineligibility_reason: 'Applicant did not meet citizenship/immigration requirements' }]
    end

    let(:params) do
      input_params.merge({ category_determinations: category_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return valid category determination' do
      expect(@result.chip_cd_for_citizen_or_immigrant).to be_truthy
    end
  end

  describe '#medicaid_chip_determination_reasons' do
    let(:member_determinations) do
      [{ kind: 'Medicaid/CHIP Determination',
         criteria_met: true,
         determination_reasons: ['mitc_override_not_lawfully_present_pregnant'],
         eligibility_overrides: eligibility_overrides }]
    end

    let(:eligibility_overrides) do
      [{
        override_rule: 'not_lawfully_present_pregnant',
        override_applied: true
      }]
    end

    let(:params) do
      input_params.merge({ member_determinations: member_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return reasons for the member determination' do
      expect(@result.medicaid_chip_determination_reasons).to eq member_determinations.first[:determination_reasons]
    end
  end

  describe '#aptc_csr_determination_reasons' do
    let(:member_determinations) do
      [{ kind: 'Insurance Assistance Determination',
         criteria_met: false,
         determination_reasons: ['income_above_threshold'],
         eligibility_overrides: eligibility_overrides }]
    end

    let(:eligibility_overrides) do
      [{
        override_rule: 'not_lawfully_present_pregnant',
        override_applied: false
      }]
    end

    let(:params) do
      input_params.merge({ member_determinations: member_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return reasons for the member determination' do
      expect(@result.aptc_csr_determination_reasons).to eq member_determinations.first[:determination_reasons]
    end
  end

  describe '#uqhp_determination_reasons' do
    let(:member_determinations) do
      [{ kind: 'Unassisted QHP Determination',
         criteria_met: true,
         determination_reasons: ['income_above_threshold'],
         eligibility_overrides: eligibility_overrides }]
    end

    let(:eligibility_overrides) do
      [{
        override_rule: 'not_lawfully_present_pregnant',
        override_applied: false
      }]
    end
    let(:params) do
      input_params.merge({ member_determinations: member_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return reasons for the member determination' do
      expect(@result.uqhp_determination_reasons).to eq member_determinations.first[:determination_reasons]
    end
  end

  describe '#totally_ineligible_determination_reasons' do
    let(:member_determinations) do
      [{ kind: 'Total Ineligibility Determination',
         criteria_met: true,
         determination_reasons: ['income_above_threshold'],
         eligibility_overrides: eligibility_overrides }]
    end

    let(:eligibility_overrides) do
      [{
        override_rule: 'not_lawfully_present_pregnant',
        override_applied: false
      }]
    end
    let(:params) do
      input_params.merge({ member_determinations: member_determinations })
    end

    before do
      ped_params = AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract.new.call(params).to_h
      @result = described_class.new(ped_params)
    end

    it 'should return reasons for the member determination' do
      expect(@result.totally_ineligible_determination_reasons).to eq member_determinations.first[:determination_reasons]
    end
  end
end
