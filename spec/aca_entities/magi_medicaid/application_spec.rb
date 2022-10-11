# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Application, dbclean: :after_each do

  context 'with valid params' do
    let(:name) { { first_name: 'first', last_name: 'last' } }
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

    let(:applicant) do
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
        age_of_applicant: 45,
        benchmark_premium: benchmark_premium,
        is_homeless: false,
        mitc_relationships: mitc_relationships,
        mitc_income: mitc_income }
    end
    let(:family_reference) { { hbx_id: '10011' } }
    let(:notice_options) { { send_eligibility_notices: true, send_open_enrollment_notices: false, paper_notification: false } }
    let(:application_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        aptc_effective_date: Date.today,
        applicants: [applicant],
        us_state: 'DC',
        hbx_id: '200000123',
        oe_start_on: Date.new(Date.today.year, 11, 1),
        submitted_at: DateTime.now,
        notice_options: notice_options,
        full_medicaid_determination: true }
    end

    context 'with one applicant' do
      before do
        app_params_result = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application_params)
        @result = if app_params_result.failure?
                    app_params_result
                  else
                    described_class.new(app_params_result.to_h)
                  end
      end

      it 'should return application entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of application' do
        expect(@result.to_h.keys.sort).to eq(application_params.keys.sort)
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
          hbx_id: '12345',
          is_insurance_assistance_eligible: 'Yes',
          annual_tax_household_income: nil,
          tax_household_members: [tax_household_member] }
      end

      let(:person_references) do
        application_params[:applicants].collect { |appl| { person_id: appl[:family_member_reference][:person_hbx_id] } }
      end

      let(:mitc_households) do
        [{ household_id: '1',
           people: person_references }]
      end

      let(:tax_return_hash) do
        { filers: person_references, dependents: [] }
      end

      let(:app_with_thh) do
        application_params.merge({ tax_households: [tax_hh], mitc_households: mitc_households, mitc_tax_returns: [tax_return_hash] })
      end

      before do
        app_params_result = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(app_with_thh)
        @result = if app_params_result.failure?
                    app_params_result
                  else
                    described_class.new(app_params_result.to_h)
                  end
      end

      it 'should return all keys of application' do
        result_app_keys = @result.to_h.keys
        input_app_keys = app_with_thh.keys
        expect(result_app_keys - input_app_keys).to be_empty
        expect(input_app_keys - result_app_keys).to be_empty
      end

      it 'should match all the input keys of applicant' do
        result_appli_keys = @result.to_h[:applicants].first.keys
        input_appli_keys = applicant.keys
        expect(result_appli_keys - input_appli_keys).to be_empty
        expect(input_appli_keys - result_appli_keys).to be_empty
      end

      it 'should match all the input keys of mitc_households' do
        result_mitc_hh_keys = @result.to_h[:mitc_households].first.keys
        input_mitc_hh_keys = mitc_households.first.keys
        expect(result_mitc_hh_keys - input_mitc_hh_keys).to be_empty
        expect(input_mitc_hh_keys - result_mitc_hh_keys).to be_empty
      end

      it 'should match all the input keys of mitc_tax_returns' do
        result_mitc_tr_keys = @result.to_h[:mitc_tax_returns].first.keys
        input_mitc_tr_keys = tax_return_hash.keys
        expect(result_mitc_tr_keys - input_mitc_tr_keys).to be_empty
        expect(input_mitc_tr_keys - result_mitc_tr_keys).to be_empty
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
        applicant.merge({ person_hbx_id: '96', name: { first_name: 'wifey', last_name: 'last' } })
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
        app_params_result = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(app_with_multi_applicants)
        @result = if app_params_result.failure?
                    app_params_result
                  else
                    described_class.new(app_params_result.to_h)
                  end
      end

      it 'should return all keys of application' do
        result_app_keys = @result.to_h.keys
        input_app_keys = app_with_multi_applicants.keys
        expect(result_app_keys - input_app_keys).to be_empty
        expect(input_app_keys - result_app_keys).to be_empty
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

    context 'with benchmark_product' do
      let(:issuer_profile_reference) { { hbx_id: '1234', fein: '123333333', hbx_carrier_id: '333333', name: 'Delta Dental', abbrev: 'DDPA' } }

      let(:health_product_reference) do
        { hios_id: '92479DC0020002', name: 'Access PPO', active_year: Date.today.year, is_dental_only: false,
          metal_level: 'gold', benefit_market_kind: 'aca_individual', product_kind: 'health', ehb_percent: '0.0',
          issuer_profile_reference: issuer_profile_reference, covers_pediatric_dental_costs: true,
          rating_method: 'Age-Based Rates', pediatric_dental_ehb: nil }
      end

      let(:dental_product_reference) do
        { hios_id: '92479DC0020011', name: 'Access PPO', active_year: Date.today.year, is_dental_only: true,
          metal_level: 'dental', benefit_market_kind: 'aca_individual', product_kind: 'dental',
          ehb_percent: '0.0', issuer_profile_reference: issuer_profile_reference, covers_pediatric_dental_costs: false,
          rating_method: 'Age-Based Rates', pediatric_dental_ehb: BigDecimal('1.0') }
      end

      let(:primary_rating_address) do
        { has_fixed_address: true, kind: 'home', address_1: '1234 street', address_3: 'landmark', city: 'test',
          county: 'County', state: 'DC', zip: '12345', country_name: 'USA', validation_status: 'ValidMatch', start_on: '2021/1/12',
          end_on: nil, lives_outside_state_temporarily: false, geocode: "00000" }
      end

      let(:member) do
        { applicant_reference: { first_name: 'first_name',
                                 last_name: 'last_name',
                                 dob: Date.today,
                                 person_hbx_id: '109990' },
          relationship_with_primary: 'self', age_on_effective_date: 20 }
      end

      let(:household) do
        { household_hbx_id: '12345', type_of_household: 'adult_only', household_ehb_premium: BigDecimal('100.75'),
          household_health_ehb_premium: BigDecimal('100.75'), health_product_reference: health_product_reference,
          household_dental_ehb_premium: BigDecimal('50.25'), dental_product_reference: dental_product_reference, members: [member] }
      end

      let(:benchmark_product) do
        { effective_date: Date.today, primary_rating_address: primary_rating_address, exchange_provided_code: 'IC01',
          household_group_ehb_premium: BigDecimal('100.75'), households: [household] }
      end

      let(:application_with_benchmark_product) { application_params.merge(benchmark_product: benchmark_product) }

      before do
        app_params_result = AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(application_with_benchmark_product)
        @result = if app_params_result.failure?
                    app_params_result
                  else
                    described_class.new(app_params_result.to_h)
                  end
      end

      it 'should return all the keys of benchmark_product' do
        expect(@result.to_h[:benchmark_product].keys).to eq(benchmark_product.keys)
      end
    end
  end
end
