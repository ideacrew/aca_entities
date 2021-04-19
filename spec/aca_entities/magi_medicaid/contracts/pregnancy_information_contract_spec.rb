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
      it 'should return failure with error messages' do
        expect(subject.call({}).errors.to_h).to eq({ is_pregnant: ['is missing'] })
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
    end
  end
end

