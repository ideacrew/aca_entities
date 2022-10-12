# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::BenefitContract,  dbclean: :after_each do
  context 'valid params' do
    context 'with kind employer_sponsored_insurance' do
      let(:input_params) do
        { kind: 'employer_sponsored_insurance',
          status: 'is_enrolled',
          employer: { employer_name: 'Employer ABC', employer_id: '123456789' },
          esi_covered: 'self_and_spouse',
          start_on: Date.today.prev_year.to_s,
          employee_cost_frequency: 'Weekly',
          employee_cost: 100.00 }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'with status is_enrolled' do
      let(:input_params) do
        { kind: 'acf_refugee_medical_assistance',
          status: 'is_enrolled',
          start_on: Date.today.prev_year.to_s }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'including end_on' do
      let(:input_params) do
        { kind: 'acf_refugee_medical_assistance',
          status: 'is_enrolled',
          start_on: Date.today.prev_year.to_s,
          end_on: nil }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'Health Reimbursement Arrangement' do
      let(:input_params) do
        { kind: 'health_reimbursement_arrangement',
          status: 'is_enrolled',
          start_on: Date.today.prev_year.to_s,
          hra_kind: [:ichra, :qsehra].sample,
          health_plan_meets_mvs_and_affordable: true,
          end_on: nil }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end
  end

  context 'invalid params' do
    context 'with kind employer_sponsored_insurance' do
      before do
        @result = subject.call(input_params)
      end

      context 'employer' do
        context 'empty employer value' do
          let(:input_params) do
            { kind: 'employer_sponsored_insurance',
              status: 'is_enrolled',
              employer: {},
              esi_covered: 'self_and_spouse',
              start_on: Date.today.prev_year.to_s,
              employee_cost_frequency: 'Weekly',
              employee_cost: 100.00 }
          end

          it 'should return failure with error message' do
            err_msg = { employer: { employer_name: ['is missing'] } }
            expect(@result.errors.to_h).to eq(err_msg)
          end
        end
      end
    end

    context 'no params' do
      it 'should return failure with error messages' do
        expect(subject.call({}).errors.to_h).to eq({ kind: ['is missing'], status: ['is missing'] })
      end
    end
  end
end
