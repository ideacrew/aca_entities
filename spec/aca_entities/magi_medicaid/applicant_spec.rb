# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Applicant, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:name) do
      { first_name: 'First', middle_name: 'middle', last_name: 'Last' }
    end
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) { { gender: 'Male', dob: Date.today.prev_year.to_s } }
    let(:benchmark_premium) do
      { health_only_lcsp_premiums: [{ member_identifier: '95', monthly_premium: 310.50 },
                                    { member_identifier: '96', monthly_premium: 310.60 }],
        health_only_slcsp_premiums: [{ member_identifier: '95', monthly_premium: 320.50 },
                                     { member_identifier: '96', monthly_premium: 320.60 }] }
    end
    let(:attestation) { { is_self_attested_disabled: false, is_self_attested_blind: false } }
    let(:family_member_reference) do
      { family_member_hbx_id: '1000',
        first_name: 'First',
        last_name: 'Last',
        person_hbx_id: '95',
        is_primary_family_member: true }
    end
    let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }
    let(:citizenship_immigration_status_information) { { citizen_status: 'us_citizen' } }
    let(:income) do
      { kind: 'alimony_and_maintenance',
        amount: 100.67,
        frequency_kind: 'Weekly',
        start_on: Date.today.prev_year.to_s,
        end_on: Date.today.to_s }
    end
    let(:deduction) do
      { kind: 'tuition_and_fees',
        amount: 1000.67,
        start_on: Date.today.prev_year.to_s,
        frequency_kind: 'Monthly',
        end_on: Date.today.to_s }
    end
    let(:benefit) do
      { kind: 'employer_sponsored_insurance',
        status: 'is_eligible',
        esi_covered: 'self_and_spouse',
        employer: { employer_name: 'ABC Employer', employer_id: '123456789' },
        start_on: Date.today.prev_year.to_s,
        employee_cost_frequency: 'Annually',
        employee_cost: 1008.92,
        end_on: Date.today.to_s }
    end

    let(:mitc_relationships) do
      [{ other_id: '95', attest_primary_responsibility: 'Y', relationship_code: '01' }]
    end

    let(:mitc_income) do
      { amount: 300,
        taxable_interest: 30,
        tax_exempt_interest: 0,
        taxable_refunds: 1,
        alimony: 0,
        capital_gain_or_loss: 0,
        pensions_and_annuities_taxable_amount: 0,
        farm_income_or_loss: 0,
        unemployment_compensation: 0,
        other_income: 0,
        magi_deductions: 0,
        adjusted_gross_income: 300,
        deductible_part_of_self_employment_tax: 0,
        ira_deduction: 1,
        student_loan_interest_deduction: 9,
        tution_and_fees: 10,
        other_magi_eligible_income: 0 }
    end

    let(:input_params) do
      { name: name,
        identifying_information: identifying_information,
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        citizenship_immigration_status_information: citizenship_immigration_status_information,
        is_applying_coverage: false,
        job_coverage_end_date: Date.today,
        prior_insurance_end_date: Date.today,
        family_member_reference: family_member_reference,
        person_hbx_id: '95',
        is_required_to_file_taxes: false,
        is_filing_as_head_of_household: false,
        pregnancy_information: pregnancy_information,
        has_job_income: true,
        has_self_employment_income: false,
        has_unemployment_income: false,
        has_other_income: false,
        has_deductions: true,
        has_enrolled_health_coverage: true,
        has_eligible_health_coverage: false,
        addresses: [],
        emails: [],
        phones: [],
        incomes: [income],
        benefits: [benefit],
        deductions: [deduction],
        is_temporarily_out_of_state: false,
        age_of_applicant: 45,
        is_claimed_as_dependent_by_non_applicant: false,
        benchmark_premium: benchmark_premium,
        is_homeless: false,
        mitc_relationships: mitc_relationships,
        mitc_income: mitc_income }
    end

    before do
      app_params_result = AcaEntities::MagiMedicaid::Contracts::ApplicantContract.new.call(input_params)
      @result = if app_params_result.failure?
                  app_params_result
                else
                  described_class.new(app_params_result.to_h)
                end
    end

    it 'should return applicant entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of applicant' do
      result_app_keys = @result.to_h.keys
      input_app_keys = input_params.keys
      expect(result_app_keys - input_app_keys).to be_empty
      expect(input_app_keys - result_app_keys).to be_empty
    end

    it 'should match all the input keys of name' do
      result_name_keys = @result.to_h[:name].keys
      input_name_keys = name.keys
      expect(result_name_keys - input_name_keys).to be_empty
      expect(input_name_keys - result_name_keys).to be_empty
    end

    it 'should match all the input keys of identifying_information' do
      result_ii_keys = @result.to_h[:identifying_information].keys
      input_ii_keys = identifying_information.keys
      expect(result_ii_keys - input_ii_keys).to be_empty
      expect(input_ii_keys - result_ii_keys).to be_empty
    end

    it 'should match all the input keys of demographic' do
      result_demographic_keys = @result.to_h[:demographic].keys
      input_demographic_keys = demographic.keys
      expect(result_demographic_keys - input_demographic_keys).to be_empty
      expect(input_demographic_keys - result_demographic_keys).to be_empty
    end

    it 'should match all the input keys of attestation' do
      result_attestation_keys = @result.to_h[:attestation].keys
      input_attestation_keys = attestation.keys
      expect(result_attestation_keys - input_attestation_keys).to be_empty
      expect(input_attestation_keys - result_attestation_keys).to be_empty
    end

    it 'should match all the input keys of citizenship_immigration_status_information' do
      result_cisi_keys = @result.to_h[:citizenship_immigration_status_information].keys
      input_cisi_keys = citizenship_immigration_status_information.keys
      expect(result_cisi_keys - input_cisi_keys).to be_empty
      expect(input_cisi_keys - result_cisi_keys).to be_empty
    end

    it 'should match all the input keys of family_member_reference' do
      result_fmr_keys = @result.to_h[:family_member_reference].keys
      input_fmr_keys = family_member_reference.keys
      expect(result_fmr_keys - input_fmr_keys).to be_empty
      expect(input_fmr_keys - result_fmr_keys).to be_empty
    end

    it 'should match all the input keys of pregnancy_information' do
      result_pi_keys = @result.to_h[:pregnancy_information].keys
      input_pi_keys = pregnancy_information.keys
      expect(result_pi_keys - input_pi_keys).to be_empty
      expect(input_pi_keys - result_pi_keys).to be_empty
    end

    it 'should match all the input keys of income' do
      result_income_keys = @result.to_h[:incomes].first.keys
      input_income_keys = income.keys
      expect(result_income_keys - input_income_keys).to be_empty
      expect(input_income_keys - result_income_keys).to be_empty
    end

    it 'should match all the input keys of benefit' do
      result_benefit_keys = @result.to_h[:benefits].first.keys
      input_benefit_keys = benefit.keys
      expect(result_benefit_keys - input_benefit_keys).to be_empty
      expect(input_benefit_keys - result_benefit_keys).to be_empty
    end

    it 'should match all the input keys of deduction' do
      result_deduction_keys = @result.to_h[:deductions].first.keys
      input_deduction_keys = deduction.keys
      expect(result_deduction_keys - input_deduction_keys).to be_empty
      expect(input_deduction_keys - result_deduction_keys).to be_empty
    end

    it 'should match all the input keys of mitc_relationship' do
      result_mitc_rel_keys = @result.to_h[:mitc_relationships].first.keys
      input_mitc_rel_keys = mitc_relationships.first.keys
      expect(result_mitc_rel_keys - input_mitc_rel_keys).to be_empty
      expect(input_mitc_rel_keys - result_mitc_rel_keys).to be_empty
    end

    it 'should match all the input keys of mitc_income' do
      result_mitc_income_keys = @result.to_h[:mitc_income].keys
      input_mitc_income_keys = mitc_income.keys
      expect(result_mitc_income_keys - input_mitc_income_keys).to be_empty
      expect(input_mitc_income_keys - result_mitc_income_keys).to be_empty
    end
  end
end
