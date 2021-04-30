# frozen_string_literal: true

require 'spec_helper'
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
    let(:address1) do
      { has_fixed_address: true,
        kind: 'home',
        address_1: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        county_name: '',
        state: 'DC',
        zip: '12345',
        country_name: 'USA',
        validation_status: 'ValidMatch',
        lives_outside_state_temporarily: false,
        start_on: Date.today.to_s,
        end_on: nil }
    end
    let(:address2) do
      { has_fixed_address: true,
        kind: 'mailing',
        address_1: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        county_name: '',
        state: 'DC',
        zip: '12345',
        country_name: 'USA',
        validation_status: 'ValidMatch',
        lives_outside_state_temporarily: true,
        start_on: Date.today.to_s,
        end_on: nil }
    end
    let(:addresses) do
      [address1, address2]
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

    let(:applicant1_mitc_relationships) do
      [{ other_id: '100', attest_primary_responsibility: 'Y', relationship_code: '01' },
       { other_id: '101', attest_primary_responsibility: 'Y', relationship_code: '02' }]
    end
    let(:applicant_hash) do
      { name: name,
        identifying_information: identifying_information,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen', is_lawful_presence_self_attested: false },
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
        age_of_applicant: 20,
        hours_worked_per_week: 0,
        is_subject_to_five_year_bar: false,
        is_five_year_bar_met: false,
        is_trafficking_victim: false,
        is_refugee: false,
        addresses: addresses,
        is_temporarily_out_of_state: false,
        mitc_relationships: applicant1_mitc_relationships,
        mitc_income: mitc_income }
    end

    let(:applicant2_mitc_relationships) do
      [{ other_id: '101', attest_primary_responsibility: 'N', relationship_code: '01' },
       { other_id: '100', attest_primary_responsibility: 'N', relationship_code: '02' }]
    end
    let(:applicant2_hash) do
      { name: name2,
        identifying_information: identifying_information,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen', is_lawful_presence_self_attested: false },
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
        age_of_applicant: 20,
        hours_worked_per_week: 0,
        is_subject_to_five_year_bar: false,
        is_five_year_bar_met: false,
        is_trafficking_victim: false,
        is_refugee: false,
        addresses: addresses,
        is_temporarily_out_of_state: false,
        mitc_relationships: applicant2_mitc_relationships,
        mitc_income: mitc_income }
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

    let(:iap_applicants) { [applicant_hash, applicant2_hash] }

    let(:person_references) do
      iap_applicants.collect { |appl| { person_id: appl[:family_member_reference][:person_hbx_id] } }
    end

    let(:mitc_households) do
      [{ household_id: '1',
         people: person_references }]
    end

    let(:tax_return_hash) do
      { filers: person_references, dependents: [] }
    end

    let(:application) do
      { us_state: 'DC',
        family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: iap_applicants,
        tax_households: [tax_hh],
        mitc_households: mitc_households,
        mitc_tax_returns: [tax_return_hash] }
    end

    let(:iap_application) do
      contract_result = ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application)
      contract_result.to_h.to_json
    end

    before do
      described_class.call(iap_application) { |record| @transform_result = record }
      @final_result = add_addtional_params(@transform_result)
      # mitc_application_result = ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract.new.call(@final_result)
      # binding.pry
      # mitc_application_result.errors.to_h
    end

    it 'should transform the payload according to instructions' do
      expect(@final_result).to have_key(:state)
      expect(@final_result).to have_key(:application_year)
      expect(@final_result[:people].count).to eq(2)

      @final_result[:people].each do |person|
        expect(person).to be_a(Hash)
        expect(person).to have_key(:person_id)
        expect(person).to have_key(:is_applicant)
        expect(person[:is_applicant]).to eq('N')
        expect(person).not_to have_key(:is_self_attested_blind)
        expect(person).not_to have_key(:is_self_attested_disabled)
        expect(person).to have_key(:is_blind_or_disabled)
        expect(person[:is_blind_or_disabled]).to eq('Y')
        expect(person).to have_key(:is_full_time_student)
        expect(person).to have_key(:is_medicare_entitled)
        expect(person).to have_key(:is_incarcerated)
        expect(person).not_to have_key(:lives_outside_state_temporarily)
        expect(person).to have_key(:resides_in_state_of_application)
        expect(person[:resides_in_state_of_application]).to eq('N')
        expect(person).to have_key(:is_self_attested_long_term_care)
        expect(person).to have_key(:has_insurance)
        expect(person).to have_key(:has_state_health_benefit)
        expect(person).to have_key(:had_prior_insurance)
        expect(person).to have_key(:is_pregnant)
        expect(person).to have_key(:children_expected_count)
        expect(person).to have_key(:is_in_post_partum_period)
        expect(person).to have_key(:is_in_former_foster_care)
        expect(person).to have_key(:had_medicaid_during_foster_care)
        expect(person).to have_key(:age_left_foster_care)
        expect(person[:age_left_foster_care]).to eq(foster_care[:age_left_foster_care])
        expect(person).to have_key(:foster_care_us_state)
        expect(person).to have_key(:is_required_to_file_taxes)
        expect(person).to have_key(:age_of_applicant)
        expect(person).to have_key(:hours_worked_per_week)
        expect(person).to have_key(:is_temporarily_out_of_state)
        expect(person[:is_temporarily_out_of_state]).to eq('N')
        expect(person).to have_key(:is_us_citizen)
        expect(person[:is_us_citizen]).to eq('Y')
        expect(person).to have_key(:immigration_status)
        expect(person).to have_key(:is_lawful_presence_self_attested)
        expect(person[:is_lawful_presence_self_attested]).to eq('N')
        expect(AcaEntities::MagiMedicaid::Mitc::Types::ImmigrationStatusCodeMap.values).to include(person[:immigration_status])
        expect(person).to have_key(:five_year_bar_applies)
        expect(person).to have_key(:is_five_year_bar_met)
        expect(person).to have_key(:is_trafficking_victim)
        expect(person).to have_key(:is_eligible_for_refugee_medical_assistance)
        expect(person).to have_key(:is_veteran)

        person[:relationships].each do |relationship|
          expect(relationship).to be_a(Hash)
          expect(relationship).to have_key(:other_id)
          expect(relationship).to have_key(:attest_primary_responsibility)
          expect(relationship).to have_key(:relationship_code)
        end

        person[:income] do |income|
          expect(income).to be_a(Hash)
          expect(income).to have_key(:amount)
          expect(income[:amount]).to eq(mitc_income[:amount])
          expect(income).to have_key(:taxable_interest)
          expect(income[:taxable_interest]).to eq(mitc_income[:taxable_interest])
          expect(income).to have_key(:tax_exempt_interest)
          expect(income[:tax_exempt_interest]).to eq(mitc_income[:tax_exempt_interest])
          expect(income).to have_key(:taxable_refunds)
          expect(income[:taxable_refunds]).to eq(mitc_income[:taxable_refunds])
          expect(income).to have_key(:alimony)
          expect(income[:alimony]).to eq(mitc_income[:alimony])
          expect(income).to have_key(:capital_gain_or_loss)
          expect(income[:capital_gain_or_loss]).to eq(mitc_income[:capital_gain_or_loss])
          expect(income).to have_key(:pensions_and_annuities_taxable_amount)
          expect(income[:pensions_and_annuities_taxable_amount]).to eq(mitc_income[:pensions_and_annuities_taxable_amount])
          expect(income).to have_key(:farm_income_or_loss)
          expect(income[:farm_income_or_loss]).to eq(mitc_income[:farm_income_or_loss])
          expect(income).to have_key(:unemployment_compensation)
          expect(income[:unemployment_compensation]).to eq(mitc_income[:unemployment_compensation])
          expect(income).to have_key(:other_income)
          expect(income[:other_income]).to eq(mitc_income[:other_income])
          expect(income).to have_key(:magi_deductions)
          expect(income[:magi_deductions]).to eq(mitc_income[:magi_deductions])
          expect(income).to have_key(:adjusted_gross_income)
          expect(income[:adjusted_gross_income]).to eq(mitc_income[:adjusted_gross_income])
          expect(income).to have_key(:deductible_part_of_self_employment_tax)
          expect(income[:deductible_part_of_self_employment_tax]).to eq(mitc_income[:deductible_part_of_self_employment_tax])
          expect(income).to have_key(:ira_deduction)
          expect(income[:ira_deduction]).to eq(mitc_income[:ira_deduction])
          expect(income).to have_key(:student_loan_interest_deduction)
          expect(income[:student_loan_interest_deduction]).to eq(mitc_income[:student_loan_interest_deduction])
          expect(income).to have_key(:tution_and_fees)
          expect(income[:tution_and_fees]).to eq(mitc_income[:tution_and_fees])
          expect(income).to have_key(:other_magi_eligible_income)
          expect(income[:other_magi_eligible_income]).to eq(mitc_income[:other_magi_eligible_income])
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
  def add_addtional_params(transform_result)
    # application_hash = JSON.parse(iap_application, symbolize_names: true)

    # Merge Application Level params
    transform_result.merge!({ name: 'IAP Application' })

    # Merge each Applicant Level params
    transform_result[:people].each do |mitc_person|
      mitc_person.merge!(addtional_person_params)
    end
    transform_result
  end

  def addtional_person_params
    { is_claimed_as_dependent_by_non_applicant: 'N',
      has_forty_title_ii_work_quarters: 'N',
      is_amerasian: 'N' }
  end

  # def tax_return_hash(application_hash, thh)
  #   filers = []
  #   dependents = []
  #   thh[:tax_household_members].each do |thh_member|
  #     applicant = applicant_by_reference(application_hash[:applicants], thh_member[:applicant_reference][:person_hbx_id])
  #     case applicant[:is_claimed_as_tax_dependent]
  #     when true
  #       dependents << { person_id: thh_member[:applicant_reference][:person_hbx_id] }
  #     when false
  #       filers << { person_id: thh_member[:applicant_reference][:person_hbx_id] }
  #     end
  #   end
  #   { filers: filers, dependents: dependents }
  # end
end