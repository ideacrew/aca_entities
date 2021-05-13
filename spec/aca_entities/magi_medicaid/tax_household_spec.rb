# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::TaxHousehold, dbclean: :after_each do

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

    let(:tax_household_member) do
      { product_eligibility_determination: product_eligibility_determination,
        applicant_reference: applicant_reference }
    end

    let(:input_params) do
      { max_aptc: 100.56,
        csr: 73,
        is_insurance_assistance_eligible: 'Yes',
        tax_household_members: [tax_household_member],
        annual_tax_household_income: 50_000.00 }
    end

    before do
      thh_params = AcaEntities::MagiMedicaid::Contracts::TaxHouseholdContract.new.call(input_params).to_h
      @result = described_class.new(thh_params)
    end

    it 'should return thh entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of thh' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of tax_household_members' do
      result_thhm_keys = @result.to_h[:tax_household_members].first.keys
      input_thhm_keys = tax_household_member.keys
      expect(result_thhm_keys - input_thhm_keys).to be_empty
      expect(input_thhm_keys - result_thhm_keys).to be_empty
    end
  end
end
