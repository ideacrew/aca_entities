# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::FosterCareContract,  dbclean: :after_each do
  context 'age of applicant is within (19..25)' do
    context 'applicant is in former foster care' do
      context 'with valid params' do
        let(:input_params) do
          { age_of_applicant: (19..25).to_a.sample,
            is_former_foster_care: true,
            age_left_foster_care: 12,
            foster_care_us_state: 'DC',
            had_medicaid_during_foster_care: false }
        end

        it 'should return success' do
          expect(subject.call(input_params)).to be_success
        end
      end

      context 'invalid params' do
        context 'bad value for us state' do
          let(:input_params) do
            { age_of_applicant: (19..25).to_a.sample,
              is_former_foster_care: true,
              age_left_foster_care: 10,
              foster_care_us_state: 'MDH',
              had_medicaid_during_foster_care: false }
          end

          it 'should return failure with error messages' do
            err_msg = /must be one of: AL, AK, AS, AZ, AR, CA, CO, CT, DE,/
            expect(subject.call(input_params).errors.to_h[:foster_care_us_state].first).to match(err_msg)
          end
        end
      end
    end

    context 'applicant is not in former foster care' do
      let(:input_params) do
        { age_of_applicant: (19..25).to_a.sample,
          is_former_foster_care: false }
      end

      it 'should return success' do
        expect(subject.call(input_params)).to be_success
      end
    end
  end

  context 'age of applicant is not within (19..25)' do
    let(:input_params) do
      { age_of_applicant: 12 }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end