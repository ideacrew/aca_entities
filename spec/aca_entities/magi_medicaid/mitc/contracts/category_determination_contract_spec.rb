# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::CategoryDeterminationContract do
  let(:required_params) do
    { category: 'Child Category',
      indicator_code: 'N' }
  end

  let(:optional_params) do
    { ineligibility_code: 115,
      ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
  end

  let(:all_params) { required_params.merge(optional_params) }

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
