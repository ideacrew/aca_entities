# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::ApplicationContract,  dbclean: :after_each do
  let(:name) { { first_name: 'first', last_name: 'last' } }
  let(:identifying_information) { { has_ssn: false } }
  let(:demographic) { { gender: 'Male', dob: Date.today.prev_year.to_s } }
  let(:attestation) { { is_disabled: false } }
  let(:family_member_reference) { { hbx_id: '1000' } }
  let(:pregnancy_information) { { is_pregnant: false, is_post_partum_period: false } }

  let(:applicant) do
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
      has_eligible_health_coverage: false }
  end
  let(:family_reference) { { hbx_id: '10011' } }

  context 'valid params' do
    let(:input_params) do
      { family_reference: family_reference,
        assistance_year: Date.today.year,
        applicants: [applicant] }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'applicants' do
      let(:input_params) { { family_reference: family_reference, assistance_year: Date.today.year, applicants: [] } }

      context 'missing applicants' do
        it 'should return a failure with error message' do
          expect(subject.call(input_params).errors.to_h).to eq({ applicants: ['at least one applicant must be present'] })
        end
      end

      context 'invalid applicant value' do
        let(:required_applicant_keys) do
          [:name, :identifying_information, :demographic, :attestation, :is_primary_applicant,
           :is_applying_coverage, :family_member_reference, :person_hbx_id, :is_required_to_file_taxes,
           :pregnancy_information, :has_job_income, :has_self_employment_income, :has_unemployment_income,
           :has_other_income, :has_deductions, :has_enrolled_health_coverage, :has_eligible_health_coverage]
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
        let(:input_params) { { family_reference: family_reference, assistance_year: Date.today.year, applicants: [local_applicant] } }
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

        context 'employer_id' do
          let(:local_benefit) do
            benefit.merge({ employer: { employer_name: 'ABC Employer', employer_id: '12345asdv' } })
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:benefits][0][:employer][:employer_id].first
            expect(err).to eq('must be numbers only')
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
        let(:input_params) { { family_reference: family_reference, assistance_year: Date.today.year, applicants: [local_applicant] } }
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
        let(:input_params) { { family_reference: family_reference, assistance_year: Date.today.year, applicants: [local_applicant] } }
        let(:income) do
          { kind: 'alimony_and_maintenance',
            amount: 100.67,
            frequency_kind: 'Weekly',
            start_on: Date.today.prev_year.to_s }
        end
        let(:local_applicant) { applicant.merge({ incomes: [local_income] }) }

        context 'employer_id' do
          let(:local_income) do
            income.merge({ employer: { employer_name: 'ABC Employer', employer_id: '12345asdv' } })
          end

          it 'should return failure with error message' do
            err = subject.call(input_params).errors.to_h[:applicants][0][:incomes][0][:employer][:employer_id].first
            expect(err).to eq('must be numbers only')
          end
        end

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

      context 'native_american_information' do
        let(:obj_call) do
          appl_params = applicant.merge({ native_american_information: { indian_tribe_member: true, tribal_id: '1234567ab' } })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end

        it 'should return failure with error message' do
          err = obj_call.errors.to_h[:applicants][0][:native_american_information][:tribal_id].first
          expect(err).to eq('must be numbers only')
        end
      end

      context 'pregnancy_information' do
        let(:obj_call) do
          appl_params = applicant.merge({ pregnancy_information: local_pregnancy })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end
        let(:pregnancy_information) do
          { is_applying_coverage: false,
            is_pregnant: true,
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

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:pregnancy_information][:pregnancy_due_on].first
            expect(err).to eq('must be filled if the applicant is pregnant')
          end
        end
      end

      context 'student' do
        let(:obj_call) do
          appl_params = applicant.merge({ student: local_student, demographic: demographic.merge({ dob: Date.new(Date.today.year - 18) }) })
          subject.call(input_params.merge({ applicants: [appl_params] }))
        end
        let(:student) do
          { age_of_applicant: (18..19).to_a.sample,
            is_student: true,
            student_kind: 'graduated',
            student_school_kind: 'graduate_school',
            student_status_end_on: nil }
        end

        context 'is_student' do
          let(:local_student) do
            student.delete(:is_student)
            student
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:student][:is_student].first
            expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
          end
        end

        context 'student_kind' do
          let(:local_student) do
            student.delete(:student_kind)
            student
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:student][:student_kind].first
            expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
          end
        end

        context 'student_school_kind' do
          let(:local_student) do
            student.delete(:student_school_kind)
            student
          end

          it 'should return failure with error message' do
            err = obj_call.errors.to_h[:applicants][0][:student][:student_school_kind].first
            expect(err).to eq("must be filled if age of applicant is within #{AcaEntities::MagiMedicaid::Types::StudentRange}.")
          end
        end
      end
    end

    context 'missing assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['is missing'] })
      end
    end

    context 'invalid value for assistance_year' do
      let(:input_params) do
        { family_reference: family_reference,
          assistance_year: 'assistance_year',
          applicants: [applicant] }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(subject.call(input_params).errors.to_h).to eq({ assistance_year: ['must be an integer'] })
      end
    end
  end
end
