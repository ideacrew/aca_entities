# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/shared_contexts/magi_medicaid_application_data'

RSpec.describe AcaEntities::MagiMedicaid::Transformers::IapTo::Mitc do
  describe 'When a valid json file passed' do
    include_context 'setup magi_medicaid application with two applicants'

    let(:magi_medicaid_application) do
      contract_result = ::AcaEntities::MagiMedicaid::Contracts::ApplicationContract.new.call(iap_application)
      contract_result.to_h.to_json
    end

    before do
      described_class.call(magi_medicaid_application) { |record| @transform_result = record }
      # mitc_application_result = ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract.new.call(@transform_result)
      # binding.pry
      # mitc_application_result.errors.to_h
    end

    it 'should transform the payload according to instructions' do
      expect(@transform_result).to have_key(:state)
      expect(@transform_result).to have_key(:name)
      expect(@transform_result[:name]).to eq(iap_application[:hbx_id])
      expect(@transform_result).to have_key(:application_year)
      expect(@transform_result[:people].count).to eq(2)

      @transform_result[:people].each do |person|

        # Mocked attributes
        expect(person).to have_key(:has_forty_title_ii_work_quarters)
        expect(person).to have_key(:is_amerasian)

        expect(person).to be_a(Hash)
        expect(person).to have_key(:person_id)
        expect(person).to have_key(:is_applicant)
        expect(person[:is_applicant]).to eq('Y')
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
        expect(person).to have_key(:is_claimed_as_dependent_by_non_applicant)
        expect(person[:is_claimed_as_dependent_by_non_applicant]).to eq('N')
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
        expect(@transform_result).to have_key(:physical_households)
      end

      it 'should add all the keys of each physical_household' do
        household = @transform_result[:physical_households].first
        expect(household).to have_key(:household_id)
        expect(household).to have_key(:people)
      end

      it 'should add all the keys of each person_reference' do
        per_ref = @transform_result[:physical_households].first[:people].first
        expect(per_ref).to have_key(:person_id)
      end
    end

    context 'should add tax_returns and embedded params' do
      it 'should add key tax_returns' do
        expect(@transform_result).to have_key(:tax_returns)
      end

      it 'should add all the keys of each tax_return' do
        tax_return = @transform_result[:tax_returns].first
        expect(tax_return).to have_key(:filers)
        expect(tax_return).to have_key(:dependents)
      end

      it 'should add all the keys of each filer' do
        filer = @transform_result[:tax_returns].first[:filers].first
        expect(filer).to have_key(:person_id)
      end
    end
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