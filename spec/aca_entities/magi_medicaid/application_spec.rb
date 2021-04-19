# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Application, dbclean: :after_each do

  context 'with valid params' do
    let(:name) { { first_name: 'first', middle_name: nil, last_name: 'last' } }
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) { { gender: 'Male', dob: Date.today.prev_year.to_s } }
    let(:attestation) { { is_disabled: false } }
    let(:family_member_reference) do
      { family_member_hbx_id: '1000',
        first_name: 'First',
        last_name: 'Last',
        person_hbx_id: '100',
        is_primary_family_member: true }
    end
    let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }

    let(:applicant) do
      { name: name,
        identifying_information: identifying_information,
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
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
    let(:application_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: [applicant] }
    end

    context 'with one applicant' do
      before do
        app_params = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application_params).to_h
        @result = described_class.new(app_params)
      end

      it 'should return application entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of application' do
        expect(@result.to_h.keys).to eq(application_params.keys)
      end

      it 'should match all the input keys of applicant' do
        result_appli_keys = @result.to_h[:applicants].first.keys
        input_appli_keys = applicant.keys
        expect(result_appli_keys - input_appli_keys).to be_empty
        expect(input_appli_keys - result_appli_keys).to be_empty
      end
    end

    context 'with tax households' do
      let(:applicant_reference) do
        { first_name: applicant[:name][:first_name],
          last_name: applicant[:name][:last_name],
          dob: applicant[:demographic][:dob],
          person_hbx_id: applicant[:person_hbx_id] }
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

      let(:tax_household_member) do
        { product_eligibility_determination: product_eligibility_determination,
          applicant_reference: applicant_reference }
      end

      let(:tax_hh) do
        { max_aptc: 100.56,
          csr: 73,
          is_insurance_assistance_eligible: 'Yes',
          tax_household_members: [tax_household_member] }
      end

      let(:app_with_thh) do
        application_params.merge({ tax_households: [tax_hh] })
      end

      before do
        app_params = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(app_with_thh).to_h
        @result = described_class.new(app_params)
      end

      it 'should return all keys of application' do
        expect(@result.to_h.keys).to eq(app_with_thh.keys)
      end

      it 'should match all the input keys of applicant' do
        result_appli_keys = @result.to_h[:applicants].first.keys
        input_appli_keys = applicant.keys
        expect(result_appli_keys - input_appli_keys).to be_empty
        expect(input_appli_keys - result_appli_keys).to be_empty
      end

      it 'should match all the input keys of tax_households' do
        result_thh_keys = @result.to_h[:tax_households].first.keys
        input_thh_keys = tax_hh.keys
        expect(result_thh_keys - input_thh_keys).to be_empty
        expect(input_thh_keys - result_thh_keys).to be_empty
      end
    end

    context 'with multiple applicants and relationships' do
      let(:applicant2) do
        applicant.merge({ person_hbx_id: '101', name: { first_name: 'wifey', middle_name: nil, last_name: 'last' } })
      end

      let(:applicant1_ref) do
        { first_name: applicant[:name][:first_name],
          last_name: applicant[:name][:last_name],
          dob: applicant[:demographic][:dob],
          person_hbx_id: applicant[:person_hbx_id] }
      end

      let(:applicant2_ref) do
        { first_name: applicant2[:name][:first_name],
          last_name: applicant2[:name][:last_name],
          dob: applicant2[:demographic][:dob],
          person_hbx_id: applicant2[:person_hbx_id] }
      end

      let(:relationships) do
        [{ kind: 'spouse', applicant_reference: applicant1_ref, relative_reference: applicant2_ref },
         { kind: 'spouse', applicant_reference: applicant2_ref, relative_reference: applicant1_ref }]
      end

      let(:app_with_multi_applicants) do
        application_params.merge({ applicants: [applicant, applicant2], relationships: relationships })
      end

      before do
        app_params = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(app_with_multi_applicants).to_h
        @result = described_class.new(app_params)
      end

      it 'should return all keys of application' do
        expect(@result.to_h.keys).to eq(app_with_multi_applicants.keys)
      end

      it 'should match all the input keys of applicant' do
        result_appli_keys = @result.to_h[:applicants].first.keys
        input_appli_keys = applicant.keys
        expect(result_appli_keys - input_appli_keys).to be_empty
        expect(input_appli_keys - result_appli_keys).to be_empty
      end

      it 'should match all the input keys of relationships' do
        result_rel_keys = @result.to_h[:relationships].first.keys
        input_rel_keys = relationships.first.keys
        expect(result_rel_keys - input_rel_keys).to be_empty
        expect(input_rel_keys - result_rel_keys).to be_empty
      end
    end
  end
end
