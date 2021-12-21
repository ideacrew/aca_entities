# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::AttestationContract,  dbclean: :after_each do
  context 'applicant not applying for coverage' do
    context 'valid params' do
      let(:optional_params) do
        { is_incarcerated: nil,
          is_self_attested_long_term_care: nil,
          is_self_attested_disabled: nil,
          is_self_attested_blind: nil }
      end

      before do
        @result = subject.call(optional_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(optional_params)
      end

      it 'should not return a failure with error messages' do
        expect(@result.errors.to_h).to eq({})
      end
    end
  end

  context 'applicant applying for coverage' do
    let(:required_params) { { is_self_attested_disabled: false, is_self_attested_blind: false } }
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
  end
end
