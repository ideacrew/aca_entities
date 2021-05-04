# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicantContract,  dbclean: :after_each do
  context 'applicant is not applying for coverage' do
    let(:name) { { first_name: 'first', last_name: 'last' } }
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) { { gender: 'Male', dob: Date.today.prev_year.to_s } }
    let(:attestation) { { is_self_attested_disabled: false, is_self_attested_blind: false } }
    let(:family_member_reference) do
      { family_member_hbx_id: '1000',
        first_name: 'first',
        last_name: 'last',
        person_hbx_id: '95',
        is_primary_family_member: true }
    end
    let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }

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
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
        is_applying_coverage: false,
        family_member_reference: family_member_reference,
        person_hbx_id: '95',
        is_required_to_file_taxes: false,
        pregnancy_information: pregnancy_information,
        has_job_income: false,
        has_self_employment_income: false,
        has_unemployment_income: false,
        has_other_income: false,
        has_deductions: false,
        has_enrolled_health_coverage: false,
        has_eligible_health_coverage: false,
        addresses: [],
        emails: [],
        phones: [],
        incomes: [],
        benefits: [],
        deductions: [],
        is_claimed_as_dependent_by_non_applicant: false,
        mitc_relationships: mitc_relationships,
        mitc_income: mitc_income }
    end

    context 'valid params' do
      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should return all keys of applicant' do
        result_app_keys = @result.to_h.keys
        input_app_keys = input_params.keys
        expect(result_app_keys - input_app_keys).to be_empty
        expect(input_app_keys - result_app_keys).to be_empty
      end
    end

    context 'invalid params' do

      context 'invalid tribal_id length' do
        let(:native_american_information) { { indian_tribe_member: true, tribal_id: '123456' } }
        let(:obj_call) do
          subject.call(input_params.merge({ native_american_information: native_american_information }))
        end

        it 'should return failure with error messages' do
          expect(obj_call.errors.to_h).to eq({ native_american_information: { tribal_id: ['length must be 9'] } })
        end
      end
    end
  end

  context 'applicant is applying for coverage' do
    let(:name) { { first_name: 'first', last_name: 'last' } }
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) do
      { gender: 'Male',
        dob: Date.today.prev_year.to_s,
        is_veteran_or_active_military: false }
    end
    let(:attestation) { { is_self_attested_disabled: false, is_self_attested_blind: false, is_incarcerated: false } }
    let(:family_member_reference) do
      { family_member_hbx_id: '1000',
        first_name: 'First',
        last_name: 'Last',
        person_hbx_id: '95',
        is_primary_family_member: true }
    end
    let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }

    let(:input_params) do
      { name: name,
        identifying_information: identifying_information,
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
        is_applying_coverage: true,
        family_member_reference: family_member_reference,
        person_hbx_id: '95',
        is_required_to_file_taxes: false,
        pregnancy_information: pregnancy_information,
        has_job_income: false,
        has_self_employment_income: false,
        has_unemployment_income: false,
        has_other_income: false,
        has_deductions: false,
        has_enrolled_health_coverage: false,
        has_eligible_health_coverage: false,
        addresses: [],
        emails: [],
        phones: [],
        incomes: [],
        benefits: [],
        deductions: [],
        is_claimed_as_dependent_by_non_applicant: false }
    end

    context 'valid params' do
      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should return result with all the param keys' do
        expect(@result.to_h.keys).to eq(input_params.keys)
      end
    end
  end
end
