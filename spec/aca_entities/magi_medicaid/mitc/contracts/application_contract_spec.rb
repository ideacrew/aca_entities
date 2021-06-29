# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::ApplicationContract do
  let(:person_params) do
    { person_id: 1000,
      is_applicant: 'Y',
      is_blind_or_disabled: 'N',
      is_full_time_student: 'Y',
      is_medicare_entitled: 'N',
      is_incarcerated: 'Y',
      resides_in_state_of_application: 'Y',
      is_claimed_as_dependent_by_non_applicant: 'Y',
      is_self_attested_long_term_care: 'N',
      has_insurance: 'Y',
      has_state_health_benefit: 'N',
      had_prior_insurance: 'Y',
      prior_insurance_end_date: Date.new,
      is_pregnant: 'N',
      children_expected_count: 0,
      is_in_post_partum_period: 'N',
      is_in_former_foster_care: 'N',
      had_medicaid_during_foster_care: 'N',
      age_left_foster_care: 0,
      foster_care_us_state: 'DC',
      is_required_to_file_taxes: 'N',
      age_of_applicant: 20,
      hours_worked_per_week: 40,
      is_temporarily_out_of_state: 'N',
      is_us_citizen: 'Y',
      is_lawful_presence_self_attested: 'N',
      immigration_status: '01',
      is_amerasian: 'N',
      has_forty_title_ii_work_quarters: 'N',
      five_year_bar_applies: 'N',
      is_five_year_bar_met: 'N',
      is_trafficking_victim: 'N',
      is_eligible_for_refugee_medical_assistance: 'Y',
      refugee_medical_assistance_start_date: Date.new,
      seven_year_limit_start_date: Date.new,
      is_veteran: 'N',
      income: { amount: 100,
                taxable_interest: 30,
                tax_exempt_interest: 0,
                taxable_refunds: 3,
                alimony: 0,
                capital_gain_or_loss: 0,
                pensions_and_annuities_taxable_amount: 0,
                farm_income_or_loss: 0,
                unemployment_compensation: 0,
                other_income: 1,
                magi_deductions: 0,
                adjusted_gross_income: 1,
                deductible_part_of_self_employment_tax: 0,
                ira_deduction: 5,
                student_loan_interest_deduction: 0,
                tution_and_fees: 0,
                other_magi_eligible_income: 0 },
      relationships: [{ other_id: 101,
                        attest_primary_responsibility: 'Y',
                        relationship_code: '01' }] }
  end

  let(:required_params) do
    { name: 'Application 100',
      state: 'DC',
      people: [person_params],
      physical_households: [{ household_id: '1000', people: [{ person_id: 1000 }] }],
      tax_returns: [{ filers: [{ person_id: 1000 }], dependents: [{ person_id: 1001 }] }] }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      before :each do
        @result = subject.call({})
      end

      it 'should return a failure' do
        expect(@result.success?).to be_falsey
      end

      it 'should list error for every required parameter' do
        expect(@result.errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'person' do
      let(:contract_call) do
        subject.call(required_params.merge({ people: [local_person] }))
      end

      context 'prior_insurance_end_date' do
        let(:local_person) { person_params.merge({ prior_insurance_end_date: [nil, ''].sample }) }

        it 'should return failure with error message' do
          err = { people: { 0 => { prior_insurance_end_date: ['cannot be blank when had_prior_insurance is Y'] } } }
          expect(contract_call.errors.to_h).to eq(err)
        end
      end

      context 'is_pregnant' do
        context 'children_expected_count' do
          let(:local_person) { person_params.merge({ is_pregnant: 'Y', children_expected_count: [nil, ''].sample }) }

          it 'should return failure with error message' do
            expect(contract_call.errors.to_h).to eq({ people: { 0 => { children_expected_count: ['cannot be blank when is_pregnant is Y'] } } })
          end
        end

        context 'is_in_post_partum_period' do
          let(:local_person) { person_params.merge({ is_pregnant: 'Y', is_in_post_partum_period: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { is_in_post_partum_period: ['cannot be blank when is_pregnant is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end
      end

      context 'is_in_former_foster_care' do
        context 'had_medicaid_during_foster_care' do
          let(:local_person) { person_params.merge({ is_in_former_foster_care: 'Y', had_medicaid_during_foster_care: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { had_medicaid_during_foster_care: ['cannot be blank when is_in_former_foster_care is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'age_left_foster_care' do
          let(:local_person) { person_params.merge({ is_in_former_foster_care: 'Y', age_left_foster_care: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { age_left_foster_care: ['cannot be blank when is_in_former_foster_care is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'foster_care_us_state' do
          let(:local_person) { person_params.merge({ is_in_former_foster_care: 'Y', foster_care_us_state: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { foster_care_us_state: ['cannot be blank when is_in_former_foster_care is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end
      end

      context 'is_lawful_presence_self_attested' do
        let(:lawful_presence_person) do
          person_params.merge({ is_lawful_presence_self_attested: 'Y',
                                immigration_status: '01',
                                is_amerasian: 'N',
                                has_forty_title_ii_work_quarters: 'N',
                                five_year_bar_applies: 'Y',
                                is_five_year_bar_met: 'N' })
        end

        context 'immigration_status' do
          let(:local_person) { lawful_presence_person.merge({ immigration_status: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { immigration_status: ['cannot be blank when is_lawful_presence_self_attested is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'is_amerasian' do
          let(:local_person) { lawful_presence_person.merge({ is_amerasian: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { is_amerasian: ['cannot be blank when is_lawful_presence_self_attested is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'has_forty_title_ii_work_quarters' do
          let(:local_person) { lawful_presence_person.merge({ has_forty_title_ii_work_quarters: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { has_forty_title_ii_work_quarters: ['cannot be blank when is_lawful_presence_self_attested is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'five_year_bar_applies' do
          let(:local_person) { lawful_presence_person.merge({ five_year_bar_applies: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { people: { 0 => { five_year_bar_applies: ['cannot be blank when is_lawful_presence_self_attested is Y'] } } }
            expect(contract_call.errors.to_h).to eq(err)
          end
        end

        context 'is_five_year_bar_met' do
          let(:local_person) { lawful_presence_person.merge({ five_year_bar_applies: 'Y', is_five_year_bar_met: [nil, ''].sample }) }

          it 'should return failure with error message' do
            err = { is_five_year_bar_met: ['cannot be blank when both is_lawful_presence_self_attested and five_year_bar_applies are Y'] }
            expect(contract_call.errors.to_h[:people][0]).to eq(err)
          end
        end
      end

      context 'refugee_medical_assistance_start_date' do
        let(:local_person) { person_params.merge({ refugee_medical_assistance_start_date: [nil, ''].sample }) }

        it 'should return failure with error message' do
          err = { refugee_medical_assistance_start_date: ['cannot be blank when is_eligible_for_refugee_medical_assistance is Y'] }
          expect(contract_call.errors.to_h[:people][0]).to eq(err)
        end
      end

      context 'refugee_medical_assistance_start_date' do
        let(:local_person) { person_params.merge({ refugee_medical_assistance_start_date: [nil, ''].sample }) }

        it 'should return failure with error message' do
          err = { 0 => { refugee_medical_assistance_start_date: ['cannot be blank when is_eligible_for_refugee_medical_assistance is Y'] } }
          expect(contract_call.errors.to_h[:people]).to eq(err)
        end
      end
    end
  end
end
