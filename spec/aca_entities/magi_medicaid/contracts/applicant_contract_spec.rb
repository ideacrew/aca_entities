# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicantContract,  dbclean: :after_each do
  context 'valid params' do
    context 'applicant is not applying for coverage' do
      let(:name) { { first_name: 'first', last_name: 'last' } }
      let(:identifying_information) { { has_ssn: false } }
      let(:demographic) { { is_applying_coverage: false, gender: 'Male', dob: Date.today.prev_year.to_s } }
      let(:attestation) { { is_applying_coverage: false, is_disabled: false } }
      let(:family_member_reference) { { hbx_id: '1000' } }
      let(:pregnancy_information) { { is_applying_coverage: false, is_pregnant: false, is_post_partum_period: false } }

      let(:input_params) do
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

    context 'applicant is applying for coverage' do
      let(:name) { { first_name: 'first', last_name: 'last' } }
      let(:identifying_information) { { has_ssn: false } }
      let(:demographic) do
        { is_applying_coverage: true,
          gender: 'Male',
          dob: Date.today.prev_year.to_s,
          is_veteran_or_active_military: false }
      end
      let(:attestation) { { is_applying_coverage: true, is_disabled: false, is_incarcerated: false } }
      let(:family_member_reference) { { hbx_id: '1000' } }
      let(:pregnancy_information) { { is_applying_coverage: true, is_pregnant: false, is_post_partum_period: false } }

      let(:input_params) do
        { name: name,
          identifying_information: identifying_information,
          demographic: demographic,
          attestation: attestation,
          is_primary_applicant: true,
          is_applying_coverage: true,
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
