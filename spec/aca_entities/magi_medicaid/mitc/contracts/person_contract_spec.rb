# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/contracts/relationship_contract'
require 'aca_entities/magi_medicaid/mitc/contracts/income_contract'
require 'aca_entities/magi_medicaid/mitc/contracts/person_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::PersonContract do
  let(:required_params) do
    { person_id: 100,
      is_applicant: 'Y',
      is_blind_or_disabled: 'Y',
      is_full_time_student: 'Y',
      is_medicare_entitled: 'Y',
      is_incarcerated: 'Y',
      resides_in_state_of_application: 'Y',
      is_claimed_as_dependent_by_non_applicant: 'Y',
      is_self_attested_long_term_care: 'Y',
      has_insurance: 'Y',
      has_state_health_benefit: 'Y',
      had_prior_insurance: 'Y',
      prior_insurance_end_date: Date.new,
      is_pregnant: 'Y',
      children_expected_count: 0,
      is_in_post_partum_period: 'Y',
      is_in_former_foster_care: 'Y',
      had_medicaid_during_foster_care: 'Y',
      age_left_foster_care: 0,
      foster_care_us_state: 'DC',
      is_required_to_file_taxes: 'Y',
      age_of_applicant: 20,
      hours_worked_per_week: 40,
      is_temporarily_out_of_state: 'Y',
      is_us_citizen: 'Y',
      is_lawful_presence_self_attested: 'Y',
      immigration_status: '01',
      is_amerasian: 'Y',
      has_forty_title_ii_work_quarters: 'Y',
      five_year_bar_applies: 'Y',
      is_five_year_bar_met: 'Y',
      is_trafficking_victim: 'Y',
      is_eligible_for_refugee_medical_assistance: 'Y',
      refugee_medical_assistance_start_date: Date.new,
      seven_year_limit_start_date: Date.new,
      is_veteran: 'Y',
      income: { amount: 100,
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
                other_magi_eligible_income: 0 },
      relationships: [{ other_id: 101, attest_primary_responsibility: 'Y', relationship_code: '01' }] }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      it 'should return a failure' do
        expect(subject.call({}).failure?).to be_truthy
      end
    end

    context 'missing prior_insurance_end_date' do
      before :each do
        required_params.delete(:prior_insurance_end_date)
        @result = subject.call(required_params)
      end

      it 'should return an error' do
        expect(@result.errors.to_h).to eq({ :prior_insurance_end_date => ['cannot be empty.'] })
      end
    end
  end
end
