# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicationContract,  dbclean: :after_each do
  let(:name) { { first_name: 'first', last_name: 'last' } }
  let(:identifying_information) { { has_ssn: false } }
  let(:demographic) { { is_applying_coverage: false, gender: 'Male', dob: Date.today.prev_year.to_s } }
  let(:attestation) { { is_applying_coverage: false, is_disabled: false } }
  let(:family_member_reference) { { hbx_id: '1000' } }
  let(:pregnancy_information) { { is_applying_coverage: false, is_pregnant: false, is_post_partum_period: false } }

  let(:applicant) do
    { name: name,
      identifying_information: identifying_information,
      demographic: demographic,
      attestation: attestation,
      is_primary_applicant: true,
      is_applying_coverage: false,
      family_member_reference: family_member_reference,
      person_hbx_id: '100',
      is_required_to_file_taxes: false,
      pregnancy_information: pregnancy_information,
      has_job_income: false,
      has_self_employment_income: false,
      has_unemployment_income: false,
      has_other_income: false,
      has_deductions: false,
      has_enrolled_health_coverage: false,
      has_eligible_health_coverage: false }
  end
  let(:family_reference) { { hbx_id: '10011' } }

  context 'valid params' do
    let(:input_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: [applicant] }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'missing assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['is missing'] })
      end
    end

    context 'invalid value for assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          assistance_year: 'assistance_year',
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['must be an integer'] })
      end
    end

    context 'invalid applicant for assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          assistance_year: 2021,
          applicants: [applicant.merge({ pregnancy_information: { is_applying_coverage: true, is_pregnant: true, is_post_partum_period: true } })] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        preg_err_hash = { expected_children_count: ['must be filled if the applicant is pregnant.'],
                          pregnancy_due_on: ['must be filled if the applicant is pregnant.'] }
        err_msg = { applicants: [{ text: 'invalid applicant',
                                   error: { pregnancy_information: [{ text: 'invalid pregnancy_information',
                                                                      error: preg_err_hash }] } }] }
        expect(subject.call(input_params).errors.to_h).to eq(err_msg)
      end
    end
  end
end
