# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicationContract,  dbclean: :after_each do
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
      first_name: name[:first_name],
      last_name: name[:last_name],
      dob: demographic[:dob],
      person_hbx_id: '95' }
  end
  let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }

  let(:mitc_relationships) do
    [{ other_id: '95', attest_primary_responsibility: 'Y', relationship_code: '01' },
     { other_id: '96', attest_primary_responsibility: 'Y', relationship_code: '02' }]
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
      citizenship_immigration_status_information: { citizen_status: 'us_citizen' },
      demographic: demographic,
      attestation: attestation,
      is_primary_applicant: true,
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
  let(:notice_options) { { send_eligibility_notices: true, send_open_enrollment_notices: false } }

  let(:family_reference) { { hbx_id: '10011' } }

  context 'with valid & invalid input params' do
    let(:input_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        aptc_effective_date: Date.today,
        applicants: [applicant],
        us_state: 'DC',
        notice_options: notice_options,
        oe_start_on: Date.new(Date.today.year, 11, 1),
        submitted_at: DateTime.now,
        hbx_id: '200000123',
        full_medicaid_determination: true }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end

    context 'with tax households' do
      let(:applicant_reference) do
        { first_name: applicant[:name][:first_name],
          last_name: applicant[:name][:last_name],
          dob: applicant[:demographic][:dob],
          person_hbx_id: applicant[:person_hbx_id] }
      end

      let(:tax_household_member) do
        { product_eligibility_determination: product_eligibility_determination,
          applicant_reference: applicant_reference }
      end

      let(:tax_hh) do
        { max_aptc: 100.56,
          hbx_id: '12345',
          is_insurance_assistance_eligible: 'Yes',
          tax_household_members: [tax_household_member] }
      end

      let(:person_references) do
        input_params[:applicants].collect { |appl| { person_id: appl[:family_member_reference][:person_hbx_id] } }
      end

      let(:mitc_households) do
        [{ household_id: '1',
           people: person_references }]
      end

      let(:tax_return_hash) do
        { filers: [{ person_id: applicant[:family_member_reference][:person_hbx_id] }], dependents: [] }
      end

      let(:app_with_thh) do
        input_params.merge({ tax_households: [tax_hh], mitc_households: mitc_households, mitc_tax_returns: [tax_return_hash] })
      end

      before do
        @result = subject.call(app_with_thh)
      end

      context 'with valid thh params' do
        context 'for aptc' do
          let(:product_eligibility_determination) do
            { is_ia_eligible: true,
              is_medicaid_chip_eligible: false,
              is_non_magi_medicaid_eligible: false,
              is_totally_ineligible: false,
              is_without_assistance: false,
              is_magi_medicaid: false,
              is_csr_eligible: false,
              magi_medicaid_monthly_household_income: 6474.42,
              medicaid_household_size: 1,
              magi_medicaid_monthly_income_limit: 3760.67,
              magi_as_percentage_of_fpl: 10.0,
              magi_medicaid_category: 'parent_caretaker' }
          end

          it 'should return success' do
            expect(@result).to be_success
          end

          it 'should include key tax_households' do
            expect(@result.to_h.keys).to include(:tax_households)
          end

          it 'should include key mitc_households' do
            expect(@result.to_h.keys).to include(:mitc_households)
          end

          it 'should include all keys of each mitc_households' do
            mitc_household = @result.to_h[:mitc_households].first
            expect(mitc_household.keys).to include(:household_id)
            expect(mitc_household.keys).to include(:people)
            expect(mitc_household[:people].first.keys).to include(:person_id)
          end

          it 'should include all keys of each mitc_tax_returns' do
            mitc_tax_return = @result.to_h[:mitc_tax_returns].first
            expect(mitc_tax_return.keys).to include(:filers)
            expect(mitc_tax_return.keys).to include(:dependents)
            expect(mitc_tax_return[:filers].first.keys).to include(:person_id)
          end
        end

        context 'for Medicaid & Chip' do
          let(:product_eligibility_determination) do
            { is_ia_eligible: false,
              is_medicaid_chip_eligible: true,
              is_non_magi_medicaid_eligible: false,
              is_totally_ineligible: false,
              is_without_assistance: false,
              is_magi_medicaid: true,
              is_csr_eligible: false,
              magi_medicaid_monthly_household_income: 6474.42,
              medicaid_household_size: 1,
              magi_medicaid_monthly_income_limit: 3760.67,
              magi_as_percentage_of_fpl: 10.0,
              magi_medicaid_category: 'parent_caretaker' }
          end

          it 'should return success' do
            expect(@result).to be_success
          end
        end

        context 'for nil Money values' do
          let(:tax_hh) do
            { max_aptc: 100.56,
              hbx_id: '12345',
              is_insurance_assistance_eligible: 'Yes',
              annual_tax_household_income: nil,
              tax_household_members: [tax_household_member] }
          end

          let(:tax_household_member) do
            { product_eligibility_determination: product_eligibility_determination,
              applicant_reference: applicant_reference }
          end

          let(:product_eligibility_determination) do
            { is_ia_eligible: false,
              is_medicaid_chip_eligible: true,
              is_non_magi_medicaid_eligible: false,
              is_totally_ineligible: false,
              is_without_assistance: false,
              is_magi_medicaid: true,
              is_csr_eligible: false,
              medicaid_household_size: 1,
              magi_medicaid_monthly_income_limit: nil,
              magi_medicaid_monthly_household_income: nil,
              magi_as_percentage_of_fpl: 10.0,
              magi_medicaid_category: 'parent_caretaker' }
          end

          it 'should return success' do
            expect(@result).to be_success
          end

          it 'should return 0.00 for annual_tax_household_income' do
            expect(@result.to_h[:tax_households].first[:annual_tax_household_income]).to eq(0.0)
          end

          it 'should return 0.00 for magi_medicaid_monthly_household_income' do
            ped_hash = @result.to_h[:tax_households].first[:tax_household_members].first[:product_eligibility_determination]
            expect(ped_hash[:magi_medicaid_monthly_household_income]).to eq(0.0)
          end

          it 'should return 0.00 for magi_medicaid_monthly_income_limit' do
            ped_hash = @result.to_h[:tax_households].first[:tax_household_members].first[:product_eligibility_determination]
            expect(ped_hash[:magi_medicaid_monthly_income_limit]).to eq(0.0)
          end
        end
      end

      context 'with invalid thh params' do
        context 'with more than one member eligibility as true' do
          let(:product_eligibility_determination) do
            { is_ia_eligible: true,
              is_medicaid_chip_eligible: true,
              is_non_magi_medicaid_eligible: true,
              is_totally_ineligible: false,
              is_without_assistance: false,
              is_magi_medicaid: false,
              is_csr_eligible: true,
              csr: '73',
              magi_medicaid_monthly_household_income: 6474.42,
              medicaid_household_size: 1,
              magi_medicaid_monthly_income_limit: 3760.67,
              magi_as_percentage_of_fpl: 10.0,
              magi_medicaid_category: 'parent_caretaker' }
          end

          it 'should return failure with error messages' do
            err_msg = /Member is eligible for more than one eligibilities:/
            expect(@result.errors.to_h[:tax_households][0][:tax_household_members][0][:product_eligibility_determination].first).to match(err_msg)
          end
        end

        context 'where member is_csr_eligible but no csr value' do
          let(:product_eligibility_determination) do
            { is_ia_eligible: true,
              is_medicaid_chip_eligible: false,
              is_non_magi_medicaid_eligible: false,
              is_totally_ineligible: false,
              is_without_assistance: false,
              is_magi_medicaid: false,
              is_csr_eligible: true,
              csr: ['', nil].sample,
              magi_medicaid_monthly_household_income: 6474.42,
              medicaid_household_size: 1,
              magi_medicaid_monthly_income_limit: 3760.67,
              magi_as_percentage_of_fpl: 10.0,
              magi_medicaid_category: 'parent_caretaker' }
          end

          it 'should return failure with error messages' do
            err_msg = 'cannot be empty when is_csr_eligible is answered.'
            expect(@result.errors.to_h[:tax_households][0][:tax_household_members][0][:product_eligibility_determination][:csr]).to include(err_msg)
          end
        end
      end
    end

    context 'with multiple applicants and relationships' do
      let(:applicant2) do
        applicant.merge({ person_hbx_id: '96',
                          name: { first_name: 'wifey', last_name: 'last' },
                          age_of_applicant: 43,
                          benchmark_premium: benchmark_premium,
                          is_homeless: false })
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
        input_params.merge({ applicants: [applicant, applicant2], relationships: relationships })
      end

      before do
        @result = subject.call(app_with_multi_applicants)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should include key tax_households' do
        expect(@result.to_h.keys).to include(:relationships)
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

      let(:application_with_benchmark_product) { input_params.merge(benchmark_product: benchmark_product) }

      before do
        @result = subject.call(application_with_benchmark_product)
      end

      it 'should return all the keys of benchmark_product' do
        expect(@result.to_h[:benchmark_product].keys).to eq(benchmark_product.keys)
      end
    end
  end

  context 'with invalid params' do
    context 'applicants' do
      let(:input_params) do
        { family_reference: family_reference,
          assistance_year: Date.today.year,
          aptc_effective_date: Date.today,
          applicants: [],
          us_state: 'DC',
          notice_options: notice_options,
          oe_start_on: Date.new(Date.today.year, 11, 1),
          hbx_id: '200000123' }
      end

      context 'missing applicants' do
        it 'should return a failure with error message' do
          expect(subject.call(input_params).errors.to_h).to eq({ applicants: ['at least one applicant must be present'] })
        end
      end

      context 'missing applicants' do
        let(:bad_person_name) do
          bad_applicant = applicant.merge({ name: 'name' })
          input_params.merge({ applicants: [bad_applicant] })
        end

        before do
          @result = subject.call(bad_person_name).errors.to_h
        end

        it 'should return a failure with error message' do
          expect { subject.call(bad_person_name) }.not_to raise_error(NoMethodError)
        end

        it 'should return a failure with error message' do
          expect(subject.call(bad_person_name).errors.to_h).to eq({ applicants: { 0 => { name:  ['must be a hash'] } } })
        end
      end

      context 'invalid applicant value' do
        let(:required_applicant_keys) do
          [:name, :identifying_information, :demographic, :attestation, :is_primary_applicant,
           :citizenship_immigration_status_information, :is_applying_coverage, :family_member_reference,
           :person_hbx_id, :is_required_to_file_taxes, :pregnancy_information, :has_job_income,
           :has_self_employment_income, :has_unemployment_income, :has_other_income, :has_deductions,
           :has_enrolled_health_coverage, :has_eligible_health_coverage,
           :age_of_applicant, :benchmark_premium, :is_homeless]
        end

        it 'should return a failure with error message' do
          err = subject.call(input_params.merge({ applicants: [test: 'test'] })).errors.to_h[:applicants][0].keys
          expect(err).to eq(required_applicant_keys)
        end
      end

      context 'nil for is_claimed_as_tax_dependent' do
        let(:obj_call) do
          appl_params = applicant.merge({ is_required_to_file_taxes: true })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err = obj_call.errors.to_h[:applicants][0]
          expect(err).to eq({ is_claimed_as_tax_dependent: ['must be answered when is_required_to_file_taxes is true'] })
        end
      end

      context 'must have at least one income' do
        let(:obj_call) do
          attr_for_income = [{ has_job_income: true },
                             { has_self_employment_income: true },
                             { has_unemployment_income: true },
                             { has_other_income: true }].sample
          appl_params = applicant.merge(attr_for_income)
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err_txt = /atleast one income should be present if has_job_income/
          expect(obj_call.errors.to_h[:applicants][0][:incomes].first).to match(err_txt)
        end
      end

      context 'must have at least one deduction' do
        let(:obj_call) do
          appl_params = applicant.merge({ has_deductions: true })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err = obj_call.errors.to_h[:applicants][0][:deductions].first
          expect(err).to eq('at least one deduction should be present if has_deductions is true')
        end
      end

      context 'must have at least one benefit' do
        let(:obj_call) do
          attr_for_benefit = [{ has_enrolled_health_coverage: true }, { has_eligible_health_coverage: true }].sample
          appl_params = applicant.merge(attr_for_benefit)
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err = obj_call.errors.to_h[:applicants][0][:benefits].first
          expect(err).to eq('at least one benefit should be present if has_enrolled_health_coverage or has_eligible_health_coverage is true')
        end
      end

      context 'attestation' do
        let(:obj_call) do
          appl_params = applicant.merge({ is_applying_coverage: true })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err = obj_call.errors.to_h[:applicants][0][:attestation][:is_incarcerated].first
          expect(err).to eq('cannot be blank when is_applying_coverage is true')
        end
      end

      context 'benefits' do
        let(:input_params) do
          { family_reference: family_reference,
            assistance_year: Date.today.year,
            aptc_effective_date: Date.today,
            applicants: [local_applicant],
            us_state: 'DC',
            notice_options: notice_options,
            oe_start_on: Date.new(Date.today.year, 11, 1),
            hbx_id: '200000123' }
        end
        let(:benefit) do
          { kind: 'employer_sponsored_insurance',
            status: 'is_eligible',
            esi_covered: 'self_and_spouse',
            employer: { employer_name: 'ABC Employer', employer_id: '123456789' },
            start_on: Date.today.prev_year.to_s,
            employee_cost_frequency: 'Annually',
            employee_cost: 1008.92 }
        end
        let(:local_applicant) { applicant.merge({ benefits: [local_benefit] }) }

        context 'employer' do
          let(:local_benefit) do
            benefit.delete(:employer)
            benefit
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:employer].first
            expect(err).to eq('cannot be blank if benefit kind is employer_sponsored_insurance')
          end
        end

        context 'esi_covered' do
          let(:local_benefit) do
            benefit.delete(:esi_covered)
            benefit
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:esi_covered].first
            expect(err).to eq('is expected when benefit kind is employer_sponsored_insurance')
          end
        end

        context 'start_on' do
          let(:local_benefit) do
            benefit.delete(:start_on)
            benefit.merge({ kind: 'acf_refugee_medical_assistance', status: 'is_enrolled' }) if [true, false].sample
            benefit
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:start_on].first
            expect(err).to eq('is expected when benefit kind is employer_sponsored_insurance or status is is_enrolled')
          end
        end

        context 'employee_cost_frequency' do
          let(:local_benefit) do
            benefit.delete(:employee_cost_frequency)
            benefit
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:employee_cost_frequency].first
            expect(err).to eq('is expected when benefit kind is employer_sponsored_insurance')
          end
        end

        context 'employee_cost' do
          let(:local_benefit) do
            benefit.delete(:employee_cost)
            benefit
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:employee_cost].first
            expect(err).to eq('is expected when benefit kind is employer_sponsored_insurance')
          end
        end

        context 'end_on' do
          let(:local_benefit) do
            benefit.merge({ end_on: Date.today.prev_year.prev_month.to_s, kind: 'acf_refugee_medical_assistance' })
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:end_on].first
            expect(err).to eq('must be after benefit start_on')
          end
        end
      end

      context 'deductions' do
        let(:input_params) do
          { family_reference: family_reference,
            assistance_year: Date.today.year,
            aptc_effective_date: Date.today,
            applicants: [local_applicant],
            us_state: 'DC',
            notice_options: notice_options,
            oe_start_on: Date.new(Date.today.year, 11, 1),
            hbx_id: '200000123' }
        end
        let(:local_deduction) do
          { kind: 'tuition_and_fees',
            amount: 1000.67,
            start_on: Date.today.prev_year.to_s,
            frequency_kind: 'Monthly',
            end_on: Date.today.prev_year.prev_month.to_s }
        end
        let(:local_applicant) { applicant.merge({ deductions: [local_deduction] }) }

        context 'end_on' do
          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:deductions][0][:end_on].first
            expect(err).to eq('must be after deduction start_on')
          end
        end
      end

      context 'demographic' do
        let(:obj_call) do
          appl_params = applicant.merge({ is_applying_coverage: true })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return a failure with error message' do
          err = obj_call.errors.to_h[:applicants][0][:demographic][:is_veteran_or_active_military].first
          expect(err).to eq('cannot be blank when is_applying_coverage is true')
        end
      end

      context 'foster_care' do
        let(:obj_call) do
          appl_params = applicant.merge({ foster_care: local_foster_care, demographic: demographic.merge({ dob: Date.new(Date.today.year - 20) }) })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end
        let(:foster_care) do
          { is_former_foster_care: true,
            age_left_foster_care: 19,
            foster_care_us_state: 'DC',
            notice_options: notice_options,
            had_medicaid_during_foster_care: false }
        end

        context 'is_former_foster_care' do
          let(:local_foster_care) do
            foster_care.delete(:is_former_foster_care)
            foster_care
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:foster_care][:is_former_foster_care].first
            expect(err).to eq("must be filled if age of applicant is within #{::AcaEntities::MagiMedicaid::Types::FosterCareRange}")
          end
        end

        context 'age_left_foster_care' do
          let(:local_foster_care) do
            foster_care.delete(:age_left_foster_care)
            foster_care
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:foster_care][:age_left_foster_care].first
            expect(err).to eq("must be filled if age of applicant is within #{::AcaEntities::MagiMedicaid::Types::FosterCareRange}")
          end
        end

        context 'foster_care_us_state' do
          let(:local_foster_care) do
            foster_care.delete(:foster_care_us_state)
            foster_care
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:foster_care][:foster_care_us_state].first
            expect(err).to eq("must be filled if age of applicant is within #{::AcaEntities::MagiMedicaid::Types::FosterCareRange}")
          end
        end

        context 'had_medicaid_during_foster_care' do
          let(:local_foster_care) do
            foster_care.delete(:had_medicaid_during_foster_care)
            foster_care
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:foster_care][:had_medicaid_during_foster_care].first
            expect(err).to eq("must be filled if age of applicant is within #{::AcaEntities::MagiMedicaid::Types::FosterCareRange}")
          end
        end
      end

      context 'incomes' do
        let(:input_params) do
          { family_reference: family_reference,
            assistance_year: Date.today.year,
            aptc_effective_date: Date.today,
            applicants: [local_applicant] }
        end
        let(:income) do
          { kind: 'alimony_and_maintenance',
            amount: 100.67,
            frequency_kind: 'Weekly',
            start_on: Date.today.prev_year.to_s }
        end
        let(:local_applicant) { applicant.merge({ incomes: [local_income] }) }

        context 'end_on' do
          let(:local_income) do
            income.merge({ end_on: Date.today.prev_year.prev_month.to_s })
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:incomes][0][:end_on].first
            expect(err).to eq('must be after income start_on')
          end
        end
      end

      context 'pregnancy_information' do
        let(:obj_call) do
          appl_params = applicant.merge({ pregnancy_information: local_pregnancy })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end
        let(:pregnancy_information) do
          { is_pregnant: true,
            expected_children_count: 2,
            pregnancy_due_on: Date.today.next_month.to_s }
        end

        context 'is_post_partum_period' do
          let(:local_pregnancy) do
            pregnancy_information.merge({ is_pregnant: false })
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:is_post_partum_period].first
            expect(err).to eq('must be filled if the applicant is not pregnant')
          end
        end

        context 'pregnancy_end_on' do
          let(:local_pregnancy) do
            pregnancy_information.merge({ is_pregnant: false, is_post_partum_period: true })
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:pregnancy_end_on].first
            expect(err).to eq('must be filled if the applicant is not pregnant')
          end
        end

        context 'is_enrolled_on_medicaid' do
          let(:obj_call) do
            appl_params = applicant.merge({ pregnancy_information: local_pregnancy, is_applying_coverage: true })
            subject.call(input_params.merge({ applicants: [appl_params] }))
          end
          let(:local_pregnancy) do
            pregnancy_information.merge({ is_pregnant: false, is_post_partum_period: true })
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:is_enrolled_on_medicaid].first
            expect(err).to eq('must be filled if the applicant is not applying for coverage, not pregnant and is in post partum period')
          end
        end

        context 'expected_children_count' do
          let(:local_pregnancy) do
            pregnancy_information.delete(:expected_children_count)
            pregnancy_information.merge({ is_pregnant: true })
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:expected_children_count].first
            expect(err).to eq('must be filled if the applicant is pregnant')
          end
        end

        context 'pregnancy_due_on' do
          let(:local_pregnancy) do
            pregnancy_information.delete(:pregnancy_due_on)
            pregnancy_information.merge({ is_pregnant: true })
          end

          # TODO: make requirement for this entry a configuration setting
          # it 'should return failure with error message' do
          #   err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:pregnancy_due_on].first
          #   expect(err).to eq('must be filled if the applicant is pregnant')
          # end
        end
      end

      # context 'student' do
      #   let(:obj_call) do
      #     appl_params = applicant.merge({ student: local_student, demographic: demographic.merge({ dob: Date.new(Date.today.year - 18) }) })
      #     subject.call(input_params.merge({ applicants: [appl_params] }))
      #   end
      #   let(:student) do
      #     { age_of_applicant: (18..19).to_a.sample,
      #       is_student: true,
      #       student_kind: 'graduated',
      #       student_school_kind: 'graduate_school',
      #       student_status_end_on: nil }
      #   end

      #   context 'is_student' do
      #     let(:local_student) do
      #       student.delete(:is_student)
      #       student
      #     end

      #     it 'should return failure with error message' do
      #       err = obj_call.errors.to_h[:applicants][0][:student][:is_student].first
      #       expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
      #     end
      #   end

      #   context 'student_kind' do
      #     let(:local_student) do
      #       student.delete(:student_kind)
      #       student
      #     end

      #     it 'should return failure with error message' do
      #       err = obj_call.errors.to_h[:applicants][0][:student][:student_kind].first
      #       expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
      #     end
      #   end

      #   context 'student_school_kind' do
      #     let(:local_student) do
      #       student.delete(:student_school_kind)
      #       student
      #     end

      #     it 'should return failure with error message' do
      #       err = obj_call.errors.to_h[:applicants][0][:student][:student_school_kind].first
      #       expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
      #     end
      #   end
      # end

      context 'phones' do
        context 'end_on' do
          let(:input_params) do
            { family_reference: family_reference,
              assistance_year: Date.today.year,
              aptc_effective_date: Date.today,
              applicants: [local_applicant] }
          end
          let(:local_phone) do
            { kind: 'home',
              area_code: '100',
              number: '1234567',
              primary: true,
              full_phone_number: '1001234567',
              start_on: Date.today.to_s,
              end_on: Date.today.prev_month.to_s }
          end
          let(:local_applicant) { applicant.merge({ phones: [local_phone] }) }

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:phones][0][:end_on].first
            expect(err).to eq('must be after phone start_on')
          end
        end
      end

      context 'emails' do
        context 'end_on' do
          let(:input_params) do
            { family_reference: family_reference,
              assistance_year: Date.today.year,
              aptc_effective_date: Date.today,
              applicants: [local_applicant] }
          end
          let(:local_email) do
            { kind: 'home',
              address: 'test@tt.com',
              start_on: Date.today.to_s,
              end_on: Date.today.prev_month.to_s }
          end
          let(:local_applicant) { applicant.merge({ emails: [local_email] }) }

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:emails][0][:end_on].first
            expect(err).to eq('must be after email start_on')
          end
        end
      end

      context 'addresses' do
        context 'end_on' do
          let(:input_params) do
            { family_reference: family_reference,
              assistance_year: Date.today.year,
              aptc_effective_date: Date.today,
              applicants: [local_applicant] }
          end
          let(:local_address) do
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
              end_on: Date.today.prev_month.to_s }
          end
          let(:local_applicant) { applicant.merge({ addresses: [local_address] }) }

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:addresses][0][:end_on].first
            expect(err).to eq('must be after address start_on')
          end
        end
      end
    end

    context 'missing assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          notice_options: notice_options,
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['is missing'],
                                                               aptc_effective_date: ['is missing'],
                                                               hbx_id: ['is missing'],
                                                               us_state: ['is missing'],
                                                               oe_start_on: ['is missing'] })
      end
    end

    context 'invalid value for assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          assistance_year: 'assistance_year',
          notice_options: notice_options,
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['must be an integer'],
                                                               aptc_effective_date: ['is missing'],
                                                               hbx_id: ['is missing'],
                                                               us_state: ['is missing'],
                                                               oe_start_on: ['is missing'] })
      end
    end

    context 'invalid notice_options' do
      context 'both send_eligibility_notices & send_open_enrollment_notices are true' do
        let(:invalid_notice_options) { { send_eligibility_notices: true, send_open_enrollment_notices: true } }
        let(:invalid_input_params) do
          { family_reference: family_reference,
            assistance_year: Date.today.year,
            aptc_effective_date: Date.today,
            applicants: [applicant],
            us_state: 'DC',
            notice_options: invalid_notice_options,
            oe_start_on: Date.new(Date.today.year, 11, 1),
            hbx_id: '200000123' }
        end

        before do
          @result = subject.call(invalid_input_params)
        end

        it 'should return failure with error message' do
          expect(@result.errors.to_h).to eq({ notice_options: ['cannot send both eligibility_notices & open_enrollment_notices.'] })
        end
      end

      context 'both send_eligibility_notices & send_open_enrollment_notices are false' do
        let(:invalid_notice_options) { { send_eligibility_notices: false, send_open_enrollment_notices: false } }
        let(:invalid_input_params) do
          { family_reference: family_reference,
            assistance_year: Date.today.year,
            aptc_effective_date: Date.today,
            applicants: [applicant],
            us_state: 'DC',
            notice_options: invalid_notice_options,
            oe_start_on: Date.new(Date.today.year, 11, 1),
            hbx_id: '200000123' }
        end

        before do
          @result = subject.call(invalid_input_params)
        end

        it 'should return failure with error message' do
          expect(@result.errors.to_h).to eq({ notice_options: ['must send eligibility_notices or open_enrollment_notices.'] })
        end
      end
    end
  end

  describe 'validation for prior_insurance_end_date' do
    let(:input_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        aptc_effective_date: Date.today,
        applicants: [local_applicant],
        us_state: 'DC',
        notice_options: notice_options,
        oe_start_on: Date.new(Date.today.year, 11, 1),
        hbx_id: '200000123' }
    end

    before do
      @result = subject.call(input_params)
    end

    context 'for failure' do
      let(:local_applicant) { applicant.merge({ had_prior_insurance: true, prior_insurance_end_date: nil }) }

      it 'should return failure with error messages' do
        expect(@result.errors.to_h).to eq({ applicants: { 0 => { prior_insurance_end_date: ['cannot be blank when had_prior_insurance is true'] } } })
      end
    end

    context 'for success' do
      let(:local_applicant) { applicant }

      it 'should not return any errors' do
        expect(@result.errors.to_h).to be_empty
      end
    end
  end
end
