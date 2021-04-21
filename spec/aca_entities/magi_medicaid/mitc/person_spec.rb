# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Person do
  describe 'with valid arguments' do
    let(:income) do
      { amount: 100,
        taxable_interest: 30,
        tax_exempt_interest: 0,
        taxable_refunds: 3,
        alimony: 0,
        capital_gain_or_loss: 0,
        pensions_and_annuities_taxable_amount: 0,
        farm_income_or_loss: 0,
        unemployment_compensation: 0,
        other_income: 1,
        magi_deductions: 0,
        adjusted_gross_income: 1,
        deductible_part_of_self_employment_tax: 0,
        ira_deduction: 5,
        student_loan_interest_deduction: 0,
        tution_and_fees: 0,
        other_magi_eligible_income: 0 }
    end

    let(:relationship) do
      { other_id: 101,
        attest_primary_responsibility: 'Y',
        relationship_code: '01' }
    end

    let(:person) do
      { person_id: 100,
        is_applicant: 'Y',
        is_blind_or_disabled: 'N',
        is_full_time_student: 'Y',
        is_medicare_entitled: 'N',
        is_incarcerated: 'Y',
        resides_in_state_of_application: 'Y',
        is_claimed_as_dependent_by_non_applicant: 'Y',
        is_self_attested_long_term_care: 'N',
        has_insurance: 'Y',
        has_state_health_benefit: 'N',
        had_prior_insurance: 'Y',
        prior_insurance_end_date: Date.new,
        is_pregnant: 'N',
        children_expected_count: 0,
        is_in_post_partum_period: 'N',
        is_in_former_foster_care: 'N',
        had_medicaid_during_foster_care: 'N',
        age_left_foster_care: 0,
        foster_care_us_state: 'DC',
        is_required_to_file_taxes: 'N',
        age_of_applicant: 20,
        hours_worked_per_week: 40,
        is_temporarily_out_of_state: 'N',
        is_us_citizen: 'Y',
        is_lawful_presence_self_attested: 'N',
        immigration_status: '01',
        is_amerasian: 'N',
        has_forty_title_ii_work_quarters: 'N',
        five_year_bar_applies: 'N',
        is_five_year_bar_met: 'N',
        is_trafficking_victim: 'N',
        is_eligible_for_refugee_medical_assistance: 'Y',
        refugee_medical_assistance_start_date: Date.new,
        seven_year_limit_start_date: Date.new,
        is_veteran: 'N',
        income: income,
        relationships: [relationship] }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::PersonContract.new.call(person).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return person entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of person' do
      expect(@result.to_h.keys).to eq(person.keys)
    end

    it 'should match all the input keys of income' do
      result_income_keys = @result.to_h[:income].keys
      input_income_keys = income.keys
      expect(result_income_keys - input_income_keys).to be_empty
      expect(input_income_keys - result_income_keys).to be_empty
    end

    it 'should match all the input keys of relationship' do
      result_relationship_keys = @result.to_h[:relationships].first.keys
      input_relationship_keys = relationship.keys
      expect(result_relationship_keys - input_relationship_keys).to be_empty
      expect(input_relationship_keys - result_relationship_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
