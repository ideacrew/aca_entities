# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicantContract,  dbclean: :after_each do
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
        has_eligible_health_coverage: false,
        addresses: [],
        emails: [],
        phones: [],
        incomes: [],
        benefits: [],
        deductions: [] }
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

    context 'invalid params' do
      context 'without incomes but has_job_income it set to true' do
        let(:invalid_params) do
          input_params.merge({ has_job_income: true })
        end

        before do
          @result = subject.call(invalid_params)
        end

        it 'should return failure with error message' do
          expect(@result.errors.to_h).to eq({ incomes: ['invalid input data for incomes.'] })
        end
      end

      context 'without deductions but has_deductions is set to true' do
        let(:invalid_params) do
          input_params.merge({ has_deductions: true })
        end

        before do
          @result = subject.call(invalid_params)
        end

        it 'should return failure with error message' do
          expect(@result.errors.to_h).to eq({ deductions: ['invalid input data for deductions.'] })
        end
      end

      context 'without benefits but has_enrolled_health_coverage is set to true' do
        let(:invalid_params) do
          input_params.merge({ has_enrolled_health_coverage: true })
        end

        before do
          @result = subject.call(invalid_params)
        end

        it 'should return failure with error message' do
          expect(@result.errors.to_h).to eq({ benefits: ['invalid input data for benefits.'] })
        end
      end

      context 'bad pregnancy_information input' do
        let(:bad_params) do
          input_params.merge({ pregnancy_information: { is_applying_coverage: true, is_pregnant: true, is_post_partum_period: true } })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { pregnancy_information: [{ text: 'invalid pregnancy_information',
                                                error: { expected_children_count: ['must be filled if the applicant is pregnant.'],
                                                         pregnancy_due_on: ['must be filled if the applicant is pregnant.'] } }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end

      context 'bad student input' do
        let(:bad_params) do
          input_params.merge({ student: { age_of_applicant: 18 }, is_applying_coverage: true })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { student: [{ text: 'invalid student', error: { is_student: ['must be filled if age of applicant is within 18..19.'] } }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end

      context 'bad foster_care input' do
        let(:bad_params) do
          input_params.merge({ foster_care: { age_of_applicant: 19 }, is_applying_coverage: true })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { foster_care: [{ error: { is_former_foster_care: ['must be filled if age of applicant is within 19..25.'] },
                                      text: 'invalid foster_care' }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end

      context 'bad addresses input' do
        let(:bad_params) do
          input_params.merge({ addresses: [{ has_fixed_address: true }] })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { addresses: [{ text: 'invalid address',
                                    error: { has_fixed_address: ['Kind cannot be blank',
                                                                 'Address1 cannot be blank',
                                                                 'City cannot be blank',
                                                                 'State cannot be blank',
                                                                 'Zip cannot be blank'] } }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end

      context 'bad phones input' do
        let(:bad_params) do
          input_params.merge({ phones: [{ kind: 'home', area_code: '10', number: '12345', primary: true }] })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { phones: [{ text: 'invalid phone',
                                 error: { area_code: ['should be of length 3 and allows numbers only'],
                                          number: ['should be of length 7 and allows numbers only'] } }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end

      context 'bad emails input' do
        let(:bad_params) do
          input_params.merge({ emails: [{ kind: 'home', address: ['test@oo', 'test.oo', 'testoo'].sample }] })
        end

        before do
          @result = subject.call(bad_params)
        end

        it 'should return failure with errors' do
          err_msg = { emails: [{ text: 'invalid email', error: { address: ['invalid email address.'] } }] }
          expect(@result.errors.to_h).to eq(err_msg)
        end
      end
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
        has_eligible_health_coverage: false,
        addresses: [],
        emails: [],
        phones: [],
        incomes: [],
        benefits: [],
        deductions: [] }
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
