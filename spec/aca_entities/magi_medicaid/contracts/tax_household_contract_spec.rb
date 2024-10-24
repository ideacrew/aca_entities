# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::TaxHouseholdContract, dbclean: :around_each do
  let(:applicant_reference) do
    { first_name: 'first',
      last_name: 'last',
      dob: Date.today.prev_year.to_s,
      person_hbx_id: '95' }
  end

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
      applicant_reference: applicant_reference }
  end

  let(:all_params) do
    {
      max_aptc: 100.56,
      hbx_id: '12345',
      is_insurance_assistance_eligible: 'Yes',
      yearly_expected_contribution: BigDecimal('102.78238'),
      tax_household_members: [tax_household_member],
      annual_tax_household_income: 50_000.00
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

    context 'without any TaxHouseholdMembers' do
      let(:invalid_thh) do
        { max_aptc: 100.56,
          hbx_id: '12345',
          is_insurance_assistance_eligible: 'Yes',
          yearly_expected_contribution: BigDecimal('102.78238'),
          tax_household_members: [{}],
          annual_tax_household_income: 50_000.00 }
      end

      before do
        @result = subject.call(invalid_thh)
      end

      it 'should return error message' do
        expect(@result.failure?).to be_truthy
      end
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
    end
  end
end
