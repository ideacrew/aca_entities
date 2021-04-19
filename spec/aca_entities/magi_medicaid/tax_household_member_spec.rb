# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::TaxHouseholdMember, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:product_eligibility_determination) do
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
        magi_medicaid_category: 'parent_caretaker' }
    end

    let(:applicant_reference) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1000' }
    end

    let(:input_params) do
      { product_eligibility_determination: product_eligibility_determination,
        applicant_reference: applicant_reference }
    end

    before do
      thh_params = AcaEntities::MagiMedicaid::Contracts::TaxHouseholdMemberContract.new.call(input_params).to_h
      @result = described_class.new(thh_params)
    end

    it 'should return thhm entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of thhm' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of product_eligibility_determination' do
      result_ped_keys = @result.to_h[:product_eligibility_determination].keys
      input_ped_keys = product_eligibility_determination.keys
      expect(result_ped_keys - input_ped_keys).to be_empty
      expect(input_ped_keys - result_ped_keys).to be_empty
    end

    it 'should match all the input keys of applicant_reference' do
      result_ar_keys = @result.to_h[:applicant_reference].keys
      input_ar_keys = applicant_reference.keys
      expect(result_ar_keys - input_ar_keys).to be_empty
      expect(input_ar_keys - result_ar_keys).to be_empty
    end
  end
end
