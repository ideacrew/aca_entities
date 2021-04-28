# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/functions/primary_applicant_builder'
require 'aca_entities/magi_medicaid/libraries/mitc_library'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/transformers/iap_to/mitc'

RSpec.describe AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc do
  describe 'When a valid json file passed' do
    let(:name) { { first_name: 'first', last_name: 'last' } }
    let(:name2) { { first_name: 'spouse', last_name: 'last' } }
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
    let(:family_member2_reference) do
      { family_member_hbx_id: '1001',
        first_name: name2[:first_name],
        last_name: name2[:last_name],
        person_hbx_id: '101',
        is_primary_family_member: false }
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
    let(:addresses) do
      [{ lives_outside_state_temporarily: false, kind: 'home' },
       { lives_outside_state_temporarily: true, kind: 'mailing' }]
    end
    let(:applicant_hash) do
      { name: name,
        identifying_information: identifying_information,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        is_applying_coverage: false,
        family_member_reference: family_member_reference,
        person_hbx_id: '100',
        is_required_to_file_taxes: true,
        is_joint_tax_filing: false,
        is_claimed_as_tax_dependent: false,
        claimed_as_tax_dependent_by: nil,
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
        is_refugee: false,
        addresses: addresses }
    end

    let(:applicant2_hash) do
      { name: name2,
        identifying_information: identifying_information,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        is_applying_coverage: false,
        family_member_reference: family_member2_reference,
        person_hbx_id: '101',
        is_required_to_file_taxes: true,
        is_joint_tax_filing: true,
        is_claimed_as_tax_dependent: false,
        claimed_as_tax_dependent_by: applicant_reference,
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
        is_refugee: false,
        addresses: addresses }
    end
    let(:family_reference) { { hbx_id: '10011' } }

    let(:applicant_reference) do
      { first_name: applicant_hash[:name][:first_name],
        last_name: applicant_hash[:name][:last_name],
        dob: applicant_hash[:demographic][:dob],
        person_hbx_id: applicant_hash[:person_hbx_id] }
    end

    let(:applicant2_reference) do
      { first_name: applicant2_hash[:name][:first_name],
        last_name: applicant2_hash[:name][:last_name],
        dob: applicant2_hash[:demographic][:dob],
        person_hbx_id: applicant2_hash[:person_hbx_id] }
    end

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

    let(:tax_household_member2) do
      { product_eligibility_determination: product_eligibility_determination,
        applicant_reference: applicant2_reference }
    end

    let(:product_eligibility_determination2) do
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

    let(:tax_household_member) do
      { product_eligibility_determination: product_eligibility_determination,
        applicant_reference: applicant_reference }
    end

    let(:tax_household_member2) do
      { product_eligibility_determination: product_eligibility_determination2,
        applicant_reference: applicant2_reference }
    end

    let(:tax_hh) do
      { max_aptc: 100.56,
        csr: 73,
        is_insurance_assistance_eligible: 'Yes',
        tax_household_members: [tax_household_member, tax_household_member2] }
    end

    let(:application) do
      { us_state: 'DC',
        family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: [applicant_hash, applicant2_hash],
        tax_households: [tax_hh] }
    end

    let(:iap_application) do
      ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application).to_h.to_json
    end

    before do
      described_class.call(iap_application) { |record| @transform_result = record }
      @final_result = add_addtional_params(@transform_result, iap_application)
    end

    it 'should transform the payload according to instructions' do
      described_class.call(iap_application) do |record|
        expect(record).to have_key(:state)
        expect(record).to have_key(:application_year)
        expect(record[:people].count).to eq(2)

        record[:people].each do |person|
          expect(person).to be_a(Hash)
          expect(person).to have_key(:person_id)
          expect(person).to have_key(:is_applicant)
          expect(person).not_to have_key(:is_self_attested_blind)
          expect(person).not_to have_key(:is_self_attested_disabled)
          expect(person).to have_key(:is_blind_or_disabled)
          expect(person[:is_blind_or_disabled]).to eq('Y')
          expect(person).to have_key(:is_full_time_student)
          expect(person).to have_key(:is_medicare_entitled)
          expect(person).to have_key(:is_incarcerated)

          # expect(person).not_to have_key(:lives_outside_state_temporarily)
          # expect(person).to have_key(:resides_in_state_of_application)
          # expect(person[:resides_in_state_of_application]).to eq('N')

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

    context 'should add physical_households and embedded params' do
      it 'should add key physical_households' do
        expect(@final_result).to have_key(:physical_households)
      end

      it 'should add all the keys of each physical_household' do
        household = @final_result[:physical_households].first
        expect(household).to have_key(:household_id)
        expect(household).to have_key(:people)
      end

      it 'should add all the keys of each person_reference' do
        per_ref = @final_result[:physical_households].first[:people].first
        expect(per_ref).to have_key(:person_id)
      end
    end

    context 'should add tax_returns and embedded params' do
      it 'should add key tax_returns' do
        expect(@final_result).to have_key(:tax_returns)
      end

      it 'should add all the keys of each tax_return' do
        tax_return = @final_result[:tax_returns].first
        expect(tax_return).to have_key(:filers)
        expect(tax_return).to have_key(:dependents)
      end

      it 'should add all the keys of each filer' do
        filer = @final_result[:tax_returns].first[:filers].first
        expect(filer).to have_key(:person_id)
      end
    end
  end

  # TODO: Will be moved to a class.
  def add_addtional_params(transform_result, iap_application)
    application_hash = JSON.parse(iap_application, symbolize_names: true)
    transform_result.merge!({ physical_households: physical_households(application_hash),
                              tax_returns: tax_returns(application_hash) })
    transform_result
  end

  def person_references(application_hash)
    application_hash[:applicants].inject([]) do |p_ref_array, applicant|
      p_ref_array << { person_id: applicant[:family_member_reference][:person_hbx_id] }
    end
  end

  # Only one household as PhysicalHousehold maps to Family
  def physical_households(application_hash)
    [{ household_id: '1', people: person_references(application_hash) }]
  end

  def applicant_by_reference(applicants, applicant_reference)
    applicants.detect do |applicant|
      applicant[:family_member_reference][:person_hbx_id] == applicant_reference[:person_hbx_id]
    end
  end

  def tax_return_hash(application_hash, thh)
    filers = []
    dependents = []
    thh[:tax_household_members].each do |thh_member|
      applicant = applicant_by_reference(application_hash[:applicants], thh_member[:applicant_reference])
      case applicant[:is_claimed_as_tax_dependent]
      when true
        dependents << { person_id: thh_member[:applicant_reference][:person_hbx_id] }
      when false
        filers << { person_id: thh_member[:applicant_reference][:person_hbx_id] }
      end
    end
    { filers: filers, dependents: dependents }
  end

  def tax_returns(application_hash)
    application_hash[:tax_households].inject([]) do |tr_array, thh|
      tr_array << tax_return_hash(application_hash, thh)
    end
  end
end