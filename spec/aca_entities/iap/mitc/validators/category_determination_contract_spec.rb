# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/iap/mitc/types'
require 'aca_entities/iap/mitc/validators/category_determination_contract'

RSpec.describe ::AcaEntities::Iap::Mitc::Validators::CategoryDeterminationContract do
  let(:required_params) do
    { indicator_code: 'Y',
      ineligibility_code: 130 }
  end
  let(:optional_params) { { ineligibility_reason: 'Testing' } }
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
