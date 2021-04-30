# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::TaxHouseholdMemberContract, dbclean: :around_each do
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

  let(:all_params) do
    {
      product_eligibility_determination: product_eligibility_determination,
      applicant_reference: applicant_reference
    }
  end

  let(:invalid_params) do
    all_params.merge({ applicant_reference: {} })
  end

  context "with invalid params" do
    before do
      @result = subject.call(invalid_params)
    end

    it "should fail validation" do
      expect(@result.success?).to be_falsey
    end

    it 'should return failure with error messages' do
      err_msg = { applicant_reference: { dob: ['is missing'], first_name: ['is missing'], last_name: ['is missing'], person_hbx_id: ['is missing'] } }
      expect(@result.errors.to_h).to eq(err_msg)
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
    end
  end
end
