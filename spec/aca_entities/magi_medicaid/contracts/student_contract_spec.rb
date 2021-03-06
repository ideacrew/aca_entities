# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::StudentContract,  dbclean: :after_each do
  context 'age of applicant is within (18..19)' do
    context 'applicant is in former foster care' do
      context 'with valid params' do
        let(:input_params) do
          { age_of_applicant: (18..19).to_a.sample,
            is_student: true,
            student_kind: 'graduated',
            student_school_kind: 'graduate_school',
            student_status_end_on: nil }
        end

        it 'should return success' do
          expect(subject.call(input_params)).to be_success
        end
      end

      context 'invalid params' do
        context 'bad value for student_kind' do
          let(:input_params) do
            { age_of_applicant: (18..19).to_a.sample,
              is_student: true,
              student_kind: 'test_student_kind',
              student_school_kind: 'graduate_school',
              student_status_end_on: nil }
          end

          it 'should return failure with error messages' do
            err_msg = /must be one of: dropped_out, elementary, english_language_institute/
            expect(subject.call(input_params).errors.to_h[:student_kind].first).to match(err_msg)
          end
        end

        context 'bad value for student_kind' do
          let(:input_params) do
            { age_of_applicant: (18..19).to_a.sample,
              is_student: true,
              student_kind: 'graduated',
              student_school_kind: 'test_student_school_kind',
              student_status_end_on: nil }
          end

          it 'should return failure with error messages' do
            err_msg = /must be one of: english_language_institute, elementary, equivalent_vocational_tech/
            expect(subject.call(input_params).errors.to_h[:student_school_kind].first).to match(err_msg)
          end
        end
      end
    end

    context 'applicant is not in former foster care' do
      let(:input_params) do
        { age_of_applicant: (18..19).to_a.sample,
          is_student: false }
      end

      it 'should return success' do
        expect(subject.call(input_params)).to be_success
      end
    end
  end

  context 'age of applicant is not within (18..19)' do
    let(:input_params) do
      { age_of_applicant: 12 }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end