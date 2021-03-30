# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/types'
require 'aca_entities/magi_medicaid/product_eligibility_determination'
require 'aca_entities/magi_medicaid/tax_household_member'
require 'aca_entities/magi_medicaid/contracts/product_eligibility_determination_contract'
require 'aca_entities/magi_medicaid/contracts/tax_household_member_contract'
require 'aca_entities/magi_medicaid/contracts/tax_household_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::TaxHouseholdContract, dbclean: :around_each do

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

  let(:tax_household_member) do
    { product_eligibility_determination: product_eligibility_determination,
      applicant_reference: '100' }
  end

  let(:all_params) do
    {
      max_aptc: 100.56,
      csr: 73,
      is_insurance_assistance_eligible: 'Yes',
      tax_household_members: [tax_household_member]
    }
  end

  let(:invalid_params) do
    all_params.merge({ tax_household_members: tax_household_member })
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call(invalid_params)
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :tax_household_members => ["must be an array"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
