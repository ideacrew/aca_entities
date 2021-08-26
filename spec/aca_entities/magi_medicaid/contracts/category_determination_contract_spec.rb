# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::CategoryDeterminationContract do
  let(:required_params) do
    { category: 'Child Category',
      indicator_code: false }
  end

  let(:optional_params) do
    { ineligibility_code: 115,
      ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'valid params' do
    context 'indicator_code is set to false' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context 'indicator_code is set to true' do
      before do
        input_params = required_params.merge({ indicator_code: true })
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'indicator_code is set to nil where the category is not applicable for applicant' do
      before do
        input_params = required_params.merge({ indicator_code: nil })
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end
  end

  context 'invalid params' do
    context 'with no parameters' do
      before :each do
        @result = subject.call({})
      end

      it 'should return a failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should list error for every required parameter' do
        expect(@result.errors.to_h.keys).to match_array required_params.keys
      end
    end

    context "with optional parameters only" do
      before :each do
        @result = subject.call(optional_params)
      end

      it 'should return a failure' do
        expect(@result.failure?).to be_truthy
      end

      it { expect(@result.error?(required_params.first[0])).to be_truthy }
    end
  end
end
