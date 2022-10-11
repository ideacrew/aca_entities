# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::TaxHousehold, dbclean: :after_each do
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
      hbx_id: '12345',
      is_insurance_assistance_eligible: 'Yes',
      yearly_expected_contribution: BigDecimal('102.78238'),
      tax_household_members: [tax_household_member],
      annual_tax_household_income: 50_000.00 }
  end

  let(:thh_params) { AcaEntities::MagiMedicaid::Contracts::TaxHouseholdContract.new.call(input_params).to_h }

  describe 'with valid arguments' do
    before do
      @result = described_class.new(thh_params)
    end

    it 'should return thh entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of thh' do
      expect(@result.to_h.keys.sort).to eq(input_params.keys.sort)
    end

    it 'should match all the input keys of tax_household_members' do
      expect(
        @result.to_h[:tax_household_members].first.keys.sort
      ).to eq(tax_household_member.keys.sort)
    end
  end

  describe '#aptc_members_aged_19_or_above' do
    let(:effective_date) { Date.today }
    let(:current_year) { effective_date.year }

    let(:applicant_reference) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: dob,
        person_hbx_id: '1000' }
    end

    let(:tax_household) { described_class.new(thh_params) }

    context 'with member aged 19 or above' do
      let(:dob) { Date.new(current_year - 25) }

      it 'should return members' do
        expect(tax_household.aptc_members_aged_19_or_above(effective_date)).not_to be_empty
      end
    end

    context 'with member aged below 19' do
      let(:dob) { Date.new(current_year - 15) }

      it 'should not return members' do
        expect(tax_household.aptc_members_aged_19_or_above(effective_date)).to be_empty
      end
    end
  end

  describe '#aptc_members_aged_below_19' do
    let(:effective_date) { Date.today }
    let(:current_year) { effective_date.year }

    let(:applicant_reference) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: dob,
        person_hbx_id: '1000' }
    end

    let(:tax_household) { described_class.new(thh_params) }

    context 'with member aged 19 or above' do
      let(:dob) { Date.new(current_year - 25) }

      it 'should not return members' do
        expect(tax_household.aptc_members_aged_below_19(effective_date)).to be_empty
      end
    end

    context 'with member aged below 19' do
      let(:dob) { Date.new(current_year - 15) }

      it 'should return members' do
        expect(tax_household.aptc_members_aged_below_19(effective_date)).not_to be_empty
      end
    end
  end
end
