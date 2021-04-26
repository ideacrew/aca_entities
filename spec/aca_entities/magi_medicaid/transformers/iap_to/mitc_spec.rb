# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/transformers/iap_to/mitc'

RSpec.describe AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc do
  describe 'When a valid json file passed' do
    let(:name) { { first_name: 'first', last_name: 'last' } }
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) do
      { gender: 'Male',
        dob: Date.today.prev_year.to_s,
        is_veteran_or_active_military: false }
    end
    let(:attestation) do
      { is_disabled: false,
        is_self_attested_blind: false,
        is_self_attested_disabled: true,
        is_incarcerated: false }
    end
    let(:family_member_reference) do
      { family_member_hbx_id: '1000',
        first_name: name[:first_name],
        last_name: name[:last_name],
        person_hbx_id: '100',
        is_primary_family_member: true }
    end
    let(:pregnancy_information) do
      { is_pregnant: false,
        is_post_partum_period: false,
        expected_children_count: nil }
    end
    let(:student) do
      { is_student: true,
        student_kind: 'graduate_school',
        student_school_kind: 'graduate_school',
        student_status_end_on: nil }
    end
    let(:foster_care) do
      { is_former_foster_care: true,
        age_left_foster_care: 10,
        foster_care_us_state: 'MA',
        had_medicaid_during_foster_care: false }
    end
    let(:applicant) do
      { name: name,
        identifying_information: identifying_information,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        is_applying_coverage: false,
        family_member_reference: family_member_reference,
        person_hbx_id: '100',
        is_required_to_file_taxes: false,
        student: student,
        foster_care: foster_care,
        pregnancy_information: pregnancy_information,
        has_job_income: false,
        has_self_employment_income: false,
        has_unemployment_income: false,
        has_other_income: false,
        has_deductions: false,
        has_enrolled_health_coverage: false,
        has_eligible_health_coverage: false,
        is_medicare_eligible: false,
        is_self_attested_long_term_care: false,
        has_insurance: false,
        has_state_health_benefit: false,
        had_prior_insurance: false,
        prior_insurance_end_date: nil,
        age_of_applicant: 20,
        hours_worked_per_week: 0,
        is_subject_to_five_year_bar: false,
        is_five_year_bar_met: false,
        is_trafficking_victim: false,
        is_refugee: false }
    end
    let(:family_reference) { { hbx_id: '10011' } }
    let(:application) do
      { us_state: 'DC',
        family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: [applicant] }
    end

    let(:iap_application) do
      ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application).to_h.to_json
    end

    it 'should transform the payload according to instructions' do
      described_class.call(iap_application) do |record|
        expect(record).to have_key(:state)
        expect(record).to have_key(:application_year)

        record[:people].each do |person|
          expect(person).to be_a(Hash)
          expect(person).to have_key(:person_id)
          expect(person).to have_key(:is_applicant)
          # expect(record).to have_key(:is_blind_or_disabled)
          # expect(record[:is_blind_or_disabled]).to eq('Y')
          expect(person).to have_key(:is_full_time_student)
          expect(person).to have_key(:is_medicare_entitled)
          expect(person).to have_key(:is_incarcerated)
          # expect(person).to have_key(:resides_in_state_of_application)
          expect(person).to have_key(:is_self_attested_long_term_care)
          expect(person).to have_key(:has_insurance)
          expect(person).to have_key(:has_state_health_benefit)
          expect(person).to have_key(:had_prior_insurance)
          expect(person).to have_key(:prior_insurance_end_date)
          expect(person).to have_key(:is_pregnant)
          expect(person).to have_key(:children_expected_count)
          expect(person).to have_key(:is_in_post_partum_period)
          expect(person).to have_key(:is_in_former_foster_care)
          expect(person).to have_key(:had_medicaid_during_foster_care)
          expect(person).to have_key(:age_left_foster_care)
          expect(person).to have_key(:foster_care_us_state)
          expect(person).to have_key(:is_required_to_file_taxes)
          expect(person).to have_key(:age_of_applicant)
          expect(person).to have_key(:hours_worked_per_week)
          expect(person).to have_key(:immigration_status)
          expect(person).to have_key(:five_year_bar_applies)
          expect(person).to have_key(:is_five_year_bar_met)
          expect(person).to have_key(:is_trafficking_victim)
          expect(person).to have_key(:is_eligible_for_refugee_medical_assistance)
          expect(person).to have_key(:is_veteran)
        end

      end
    end
  end
end
