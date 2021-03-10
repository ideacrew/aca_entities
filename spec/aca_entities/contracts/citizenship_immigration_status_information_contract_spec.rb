# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/citizenship_immigration_status_information_contract'

RSpec.describe ::AcaEntities::Contracts::CitizenshipImmigrationStatusInformationContract, dbclean: :after_each do

  let(:required_params) { { us_citizen: false } }

  let(:optional_params) do
    { naturalized_citizen: true,
      sevis_id: '123456789',
      same_name: true,
      eligible_immigration_status: true,
      is_resident_pre_1996: false }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it { expect(subject.call(optional_params).error?(required_params.first[0])).to be_truthy }
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      let(:input_params) { { us_citizen: true } }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq input_params }
    end

    context 'applicant is not a us_citizen' do
      let(:input_params) { { us_citizen: false, eligible_immigration_status: false } }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq input_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
