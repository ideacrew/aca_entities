# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/types'
require 'aca_entities/iap/mitc/types'
require 'aca_entities/iap/mitc/validators/tax_return_contract'
require 'aca_entities/iap/mitc/validators/person_reference_contract'
require 'aca_entities/iap/mitc/validators/category_determination_contract'
require 'aca_entities/iap/mitc/validators/household_contract'
require 'aca_entities/iap/mitc/validators/relationship_contract'
require 'aca_entities/iap/mitc/validators/income_contract'
require 'aca_entities/iap/mitc/validators/person_contract'
require 'aca_entities/iap/mitc/validators/application_contract'

RSpec.describe ::AcaEntities::Iap::Mitc::Validators::ApplicationContract do
  let(:person_params) do
    { person_id: 100,
      is_applicant: 'Y',
      is_blind_or_disabled: 'N',
      is_full_time_student: 'Y',
      is_medicare_entitled: 'N',
      is_incarcerated: 'Y',
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
      relationships: [{ other_id: 101,
                        attest_primary_responsibility: 'Y',
                        relationship_code: '01' }] }
  end

  let(:required_params) do
    { name: 'Application 100',
      state: 'DC',
      application_year: 2021,
      people: [person_params],
      physical_households: [{ household_id: 1000, people: [{ person_id: 100 }] }],
      tax_returns: [{ filers: [{ person_id: 100 }], dependents: [{ person_id: 101 }] }] }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      before :each do
        @result = subject.call({})
      end

      it 'should return a failure' do
        expect(@result.success?).to be_falsey
      end

      it 'should list error for every required parameter' do
        expect(@result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
