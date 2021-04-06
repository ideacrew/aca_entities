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

    let(:tax_household_member) do
      { product_eligibility_determination: product_eligibility_determination,
        applicant_reference: '100' }
    end

    let(:input_params) do
      { max_aptc: 100.56,
        csr: 73,
        is_insurance_assistance_eligible: 'Yes',
        tax_household_members: [tax_household_member] }
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
      msg = /:is_insurance_assistance_eligible violates constraints/
      expect { described_class.new(is_insurance_assistance_eligible: 'Test') }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
