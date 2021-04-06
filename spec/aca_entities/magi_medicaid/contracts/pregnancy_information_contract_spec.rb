# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::PregnancyInformationContract,  dbclean: :after_each do
  context 'applicant is pregnant' do
    context 'valid params' do
      let(:input_params) do
        { is_applying_coverage: false,
          is_pregnant: true,
          expected_children_count: 2,
          pregnancy_due_on: Date.today.next_month.to_s }
      end

      it 'should return success' do
        expect(subject.call(input_params)).to be_success
      end
    end

    context 'invalid params' do
      context 'missing value for expected_children_count' do
        let(:input_params) do
          { is_applying_coverage: false,
            is_pregnant: true,
            expected_children_count: nil,
            pregnancy_due_on: Date.today.next_month.to_s }
        end

        it 'should return failure with error message' do
          expect(subject.call(input_params).errors.to_h).to eq({ expected_children_count: ['must be filled if the applicant is pregnant.'] })
        end
      end

      context 'missing value for pregnancy_due_on' do
        let(:input_params) do
          { is_applying_coverage: false,
            is_pregnant: true,
            expected_children_count: 2,
            pregnancy_due_on: nil }
        end

        it 'should return failure with error message' do
          expect(subject.call(input_params).errors.to_h).to eq({ pregnancy_due_on: ['must be filled if the applicant is pregnant.'] })
        end
      end
    end
  end

  context 'applicant is not pregnant' do
    context 'applicant is in is_post_partum_period' do
      context 'valid params' do
        let(:input_params) do
          { is_applying_coverage: true,
            is_pregnant: false,
            is_post_partum_period: true,
            is_enrolled_on_medicaid: false,
            pregnancy_end_on: Date.today.next_month.to_s }
        end

        it { expect(subject.call(input_params)).to be_success }
      end

      context 'invalid params with missing end_on value' do
        let(:input_params) do
          { is_applying_coverage: true,
            is_pregnant: false,
            is_post_partum_period: true,
            is_enrolled_on_medicaid: false,
            pregnancy_end_on: nil }
        end

        it 'should return error with a message' do
          err_msg = 'must be filled if the applicant is not pregnant and is in post partum period.'
          expect(subject.call(input_params).errors.to_h).to eq({ pregnancy_end_on: [err_msg] })
        end
      end

      context 'invalid params with missing is_enrolled_on_medicaid value' do
        let(:input_params) do
          { is_applying_coverage: true,
            is_pregnant: false,
            is_post_partum_period: true,
            is_enrolled_on_medicaid: nil,
            pregnancy_end_on: Date.today.next_month.to_s }
        end

        it 'should return error with a message' do
          err_msg = 'must be filled if the applicant is not applying for coverage, not pregnant and is in post partum period.'
          expect(subject.call(input_params).errors.to_h).to eq({ is_enrolled_on_medicaid: [err_msg] })
        end
      end
    end
  end
end

