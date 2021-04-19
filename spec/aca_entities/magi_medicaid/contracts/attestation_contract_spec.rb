# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::AttestationContract,  dbclean: :after_each do
  context 'applicant not applying for coverage' do
    context 'valid params' do
      let(:required_params) { { is_disabled: false } }
      let(:optional_params) do
        { is_incarcerated: nil,
          is_self_attested_long_term_care: nil }
      end
      let(:all_params) { required_params.merge(optional_params) }

      before do
        @result = subject.call(all_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(all_params)
      end
    end

    context 'invalid params' do
      before do
        @result = subject.call({})
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        expect(@result.errors.to_h).to eq({ is_disabled: ['is missing'] })
      end
    end
  end

  context 'applicant applying for coverage' do
    let(:required_params) { { is_disabled: false } }
    let(:all_params) { required_params.merge(optional_params) }

    context 'valid params' do
      let(:optional_params) do
        { is_incarcerated: false,
          is_self_attested_long_term_care: false }
      end

      before do
        @result = subject.call(all_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(all_params)
      end
    end

    context 'invalid params' do
      before do
        @result = subject.call({})
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return failure with error messages' do
        expect(@result.errors.to_h).to eq({ is_disabled: ['is missing'] })
      end
    end
  end
end
