# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe AcaEntities::MagiMedicaid::Mitc::Transformers::MitcTo::Request do
  describe 'When a valid json file passed' do
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
    let(:person1) do
      { person_id: 95,
        is_applicant: 'N',
        is_blind_or_disabled: 'Y',
        is_full_time_student: 'Y',
        is_medicare_entitled: 'N',
        is_incarcerated: 'N',
        resides_in_state_of_application: 'N',
        is_claimed_as_dependent_by_non_applicant: 'N',
        is_self_attested_long_term_care: 'N',
        has_insurance: 'N',
        has_state_health_benefit: 'N',
        had_prior_insurance: 'Y',
        prior_insurance_end_date: Date.today.prev_month,
        is_pregnant: 'N',
        children_expected_count: nil,
        is_in_postpartum_period: 'N',
        is_in_former_foster_care: 'Y',
        had_medicaid_during_foster_care: 'N',
        age_left_foster_care: 10,
        foster_care_us_state: 'MA',
        is_required_to_file_taxes: 'Y',
        age_of_applicant: 20,
        hours_worked_per_week: 0,
        is_temporarily_out_of_state: 'N',
        is_us_citizen: 'Y',
        is_lawful_presence_self_attested: 'N',
        immigration_status: '99',
        is_amerasian: 'N',
        has_forty_title_ii_work_quarters: 'N',
        five_year_bar_applies: 'N',
        is_five_year_bar_met: 'N',
        is_trafficking_victim: 'N',
        is_eligible_for_refugee_medical_assistance: 'N',
        refugee_medical_assistance_start_date: nil,
        seven_year_limit_start_date: nil,
        is_veteran: 'N',
        income: mitc_income,
        relationships: [{ other_id: 95, attest_primary_responsibility: 'Y', relationship_code: '01' },
                        { other_id: 96, attest_primary_responsibility: 'Y', relationship_code: '02' }] }
    end
    let(:person2) do
      { person_id: 96,
        is_applicant: 'N',
        is_blind_or_disabled: 'Y',
        is_full_time_student: 'Y',
        is_medicare_entitled: 'N',
        is_incarcerated: 'N',
        resides_in_state_of_application: 'N',
        is_claimed_as_dependent_by_non_applicant: 'N',
        is_self_attested_long_term_care: 'N',
        has_insurance: 'N',
        has_state_health_benefit: 'N',
        had_prior_insurance: 'Y',
        prior_insurance_end_date: Date.today.prev_month,
        is_pregnant: 'N',
        children_expected_count: nil,
        is_in_postpartum_period: 'N',
        is_in_former_foster_care: 'Y',
        had_medicaid_during_foster_care: 'N',
        age_left_foster_care: 10,
        foster_care_us_state: 'MA',
        is_required_to_file_taxes: 'Y',
        age_of_applicant: 20,
        hours_worked_per_week: 0,
        is_temporarily_out_of_state: 'N',
        is_us_citizen: 'Y',
        is_lawful_presence_self_attested: 'N',
        immigration_status: '99',
        is_amerasian: 'N',
        has_forty_title_ii_work_quarters: 'N',
        five_year_bar_applies: 'N',
        is_five_year_bar_met: 'N',
        is_trafficking_victim: 'N',
        is_eligible_for_refugee_medical_assistance: 'N',
        refugee_medical_assistance_start_date: nil,
        seven_year_limit_start_date: nil,
        is_veteran: 'N',
        income: mitc_income,
        relationships: [{ other_id: 96, attest_primary_responsibility: 'N', relationship_code: '01' },
                        { other_id: 95, attest_primary_responsibility: 'N', relationship_code: '02' }] }
    end
    let(:household) { { household_id: '1', people: [{ person_id: 95 }, { person_id: 96 }] } }
    let(:mitc_application) do
      { name: 'IAP Application',
        state: 'DC',
        application_year: 2021,
        people: [person1, person2],
        physical_households: [household],
        tax_returns: [{ filers: [{ person_id: 95 }, { person_id: 96 }], dependents: [] }] }
    end

    let(:mitc_application_json) do
      contract_result = ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract.new.call(mitc_application)
      contract_result.to_h.to_json
    end

    before do
      described_class.call(mitc_application_json) { |record| @transform_result = record }
    end

    it 'should transform all the application level attributes' do
      expect(@transform_result).to have_key(:State)
      expect(@transform_result[:State]).to eq(mitc_application[:state])
      expect(@transform_result).to have_key(:'Application Year')
      expect(@transform_result[:'Application Year']).to eq(mitc_application[:application_year])
      expect(@transform_result).to have_key(:Name)
      expect(@transform_result[:Name]).to eq(mitc_application[:name])
      expect(@transform_result[:People].count).to eq(2)
    end

    it 'should transform all the applicant level attributes' do
      @transform_result[:People].each do |person|
        expect(person).to be_a(Hash)
        expect(person).to have_key(:'Person ID')
        expect(person).to have_key(:'Is Applicant')
        expect(person[:'Is Applicant']).to eq(person1[:is_applicant])
        expect(person).to have_key(:'Applicant Attest Blind or Disabled')
        expect(person[:'Applicant Attest Blind or Disabled']).to eq(person1[:is_blind_or_disabled])
        expect(person).to have_key(:'Student Indicator')
        expect(person[:'Student Indicator']).to eq(person1[:is_full_time_student])
        expect(person).to have_key(:'Medicare Entitlement Indicator')
        expect(person[:'Medicare Entitlement Indicator']).to eq(person1[:is_medicare_entitled])
        expect(person).to have_key(:'Incarceration Status')
        expect(person[:'Incarceration Status']).to eq(person1[:is_incarcerated])
        expect(person).to have_key(:'Lives In State')
        expect(person[:'Lives In State']).to eq(person1[:resides_in_state_of_application])
        expect(person).to have_key(:'Claimed as Dependent by Person Not on Application')
        expect(person[:'Claimed as Dependent by Person Not on Application']).to eq(person1[:is_claimed_as_dependent_by_non_applicant])
        expect(person).to have_key(:'Applicant Attest Long Term Care')
        expect(person[:'Applicant Attest Long Term Care']).to eq(person1[:is_self_attested_long_term_care])
        expect(person).to have_key(:'Has Insurance')
        expect(person[:'Has Insurance']).to eq(person1[:has_insurance])
        expect(person).to have_key(:'State Health Benefits Through Public Employee')
        expect(person[:'State Health Benefits Through Public Employee']).to eq(person1[:has_state_health_benefit])
        expect(person).to have_key(:'Prior Insurance')
        expect(person[:'Prior Insurance']).to eq(person1[:had_prior_insurance])
        expect(person).to have_key(:'Prior Insurance End Date')
        expect(person[:'Prior Insurance End Date']).to eq(person1[:prior_insurance_end_date].to_s)
        expect(person[:'Prior Insurance End Date']).to match(/\d{4}-\d{2}-\d{2}/)
        expect(person).to have_key(:'Applicant Pregnant Indicator')
        expect(person[:'Applicant Pregnant Indicator']).to eq(person1[:is_pregnant])
        expect(person).to have_key(:'Number of Children Expected')
        expect(person[:'Number of Children Expected']).to eq(person1[:children_expected_count])
        expect(person).to have_key(:'Applicant Postpartum Period Indicator')
        expect(person[:'Applicant Postpartum Period Indicator']).to eq(person1[:is_in_postpartum_period])
        expect(person).to have_key(:'Former Foster Care')
        expect(person[:'Former Foster Care']).to eq(person1[:is_in_former_foster_care])
        expect(person).to have_key(:'Had Medicaid During Foster Care')
        expect(person[:'Had Medicaid During Foster Care']).to eq(person1[:had_medicaid_during_foster_care])
        expect(person).to have_key(:'Age Left Foster Care')
        expect(person[:'Age Left Foster Care']).to eq(person1[:age_left_foster_care])
        expect(person).to have_key(:'Foster Care State')
        expect(person[:'Foster Care State']).to eq(person1[:foster_care_us_state])
        expect(person).to have_key(:'Required to File Taxes')
        expect(person[:'Required to File Taxes']).to eq(person1[:is_required_to_file_taxes])
        expect(person).to have_key(:'Applicant Age')
        expect(person[:'Applicant Age']).to eq(person1[:age_of_applicant])
        expect(person).to have_key(:'Hours Worked Per Week')
        expect(person[:'Hours Worked Per Week']).to eq(person1[:hours_worked_per_week])
        expect(person).to have_key(:'Claimer Is Out of State')
        expect(person[:'Claimer Is Out of State']).to eq(person1[:is_temporarily_out_of_state])
        expect(person).to have_key(:'US Citizen Indicator')
        expect(person[:'US Citizen Indicator']).to eq(person1[:is_us_citizen])
        expect(person).to have_key(:'Lawful Presence Attested')
        expect(person[:'Lawful Presence Attested']).to eq(person1[:is_lawful_presence_self_attested])
        expect(person).to have_key(:'Immigration Status')
        expect(person[:'Immigration Status']).to eq(person1[:immigration_status])
        expect(person).to have_key(:'Amerasian Immigrant')
        expect(person[:'Amerasian Immigrant']).to eq(person1[:is_amerasian])
        expect(person).to have_key(:'Applicant Has 40 Title II Work Quarters')
        expect(person[:'Applicant Has 40 Title II Work Quarters']).to eq(person1[:has_forty_title_ii_work_quarters])
        expect(person).to have_key(:'Five Year Bar Applies')
        expect(person[:'Five Year Bar Applies']).to eq(person1[:five_year_bar_applies])
        expect(person).to have_key(:'Five Year Bar Met')
        expect(person[:'Five Year Bar Met']).to eq(person1[:is_five_year_bar_met])
        expect(person).to have_key(:'Victim of Trafficking')
        expect(person[:'Victim of Trafficking']).to eq(person1[:is_trafficking_victim])
        expect(person).to have_key(:'Refugee Status')
        expect(person[:'Refugee Status']).to eq(person1[:is_eligible_for_refugee_medical_assistance])
        expect(person).to have_key(:'Refugee Medical Assistance Start Date')
        expect(person[:'Refugee Medical Assistance Start Date']).to eq(person1[:refugee_medical_assistance_start_date])
        expect(person).to have_key(:'Seven Year Limit Start Date')
        expect(person[:'Seven Year Limit Start Date']).to eq(person1[:seven_year_limit_start_date])
        expect(person).to have_key(:'Veteran Status')
        expect(person[:'Veteran Status']).to eq(person1[:is_veteran])

        person[:Relationships].each do |relationship|
          expect(relationship).to be_a(Hash)
          expect(relationship).to have_key(:'Other ID')
          expect(relationship).to have_key(:'Attest Primary Responsibility')
          expect(relationship).to have_key(:'Relationship Code')
        end

        income = person[:income]
        expect(income).to be_a(Hash)
        expect(income).to have_key(:"Wages, Salaries, Tips")
        expect(income[:'Wages, Salaries, Tips']).to eq(mitc_income[:amount])
        expect(income).to have_key(:'Taxable Interest')
        expect(income[:'Taxable Interest']).to eq(mitc_income[:taxable_interest])
        expect(income).to have_key(:'Tax-Exempt Interest')
        expect(income[:'Tax-Exempt Interest']).to eq(mitc_income[:tax_exempt_interest])
        expect(income).to have_key(:'Taxable Refunds, Credits, or Offsets of State and Local Income Taxes')
        expect(income[:'Taxable Refunds, Credits, or Offsets of State and Local Income Taxes']).to eq(mitc_income[:taxable_refunds])
        expect(income).to have_key(:Alimony)
        expect(income[:Alimony]).to eq(mitc_income[:alimony])
        expect(income).to have_key(:"Capital Gain or Loss")
        expect(income[:'Capital Gain or Loss']).to eq(mitc_income[:capital_gain_or_loss])
        expect(income).to have_key(:'Pensions and Annuities Taxable Amount')
        expect(income[:'Pensions and Annuities Taxable Amount']).to eq(mitc_income[:pensions_and_annuities_taxable_amount])
        expect(income).to have_key(:'Farm Income or Loss')
        expect(income[:'Farm Income or Loss']).to eq(mitc_income[:farm_income_or_loss])
        expect(income).to have_key(:'Unemployment Compensation')
        expect(income[:'Unemployment Compensation']).to eq(mitc_income[:unemployment_compensation])
        expect(income).to have_key(:'Other Income')
        expect(income[:'Other Income']).to eq(mitc_income[:other_income])
        expect(income).to have_key(:'MAGI Deductions')
        expect(income[:'MAGI Deductions']).to eq(mitc_income[:magi_deductions])
        expect(income).to have_key(:AGI)
        expect(income[:AGI]).to eq(mitc_income[:adjusted_gross_income])
        expect(income).to have_key(:'Deductible Part of Self-Employment Tax')
        expect(income[:'Deductible Part of Self-Employment Tax']).to eq(mitc_income[:deductible_part_of_self_employment_tax])
        expect(income).to have_key(:'IRA Deduction')
        expect(income[:'IRA Deduction']).to eq(mitc_income[:ira_deduction])
        expect(income).to have_key(:'Student Loan Interest Deduction')
        expect(income[:'Student Loan Interest Deduction']).to eq(mitc_income[:student_loan_interest_deduction])
        expect(income).to have_key(:'Tuition and Fees')
        expect(income[:'Tuition and Fees']).to eq(mitc_income[:tution_and_fees])
        expect(income).to have_key(:'Other MAGI-Eligible Income')
        expect(income[:'Other MAGI-Eligible Income']).to eq(mitc_income[:other_magi_eligible_income])
      end
    end

    it 'should transform all the physical_households level attributes' do
      @transform_result[:'Physical Households'].each do |physical_hh|
        expect(physical_hh).to be_a(Hash)
        expect(physical_hh).to have_key(:'Household ID')
        expect(physical_hh[:'Household ID']).to eq(household[:household_id])
        expect(physical_hh).to have_key(:People)
        expect(physical_hh[:People].map(&:values).flatten).to eq(household[:people].map(&:values).flatten)
      end
    end

    it 'should transform all the tax_returns level attributes' do
      @transform_result[:'Tax Returns'].each do |taxreturn|
        expect(taxreturn).to be_a(Hash)
        expect(taxreturn).to have_key(:Filers)
        expect(taxreturn).to have_key(:Dependents)

        taxreturn[:Filers].each do |filer|
          expect(filer).to have_key(:'Person ID')
        end

        taxreturn[:Dependents].each do |filer|
          expect(filer).to have_key(:'Person ID')
        end
      end
    end
  end
end