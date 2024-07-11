# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/verification_metadata_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::VerificationMetadataContract, dbclean: :after_each do

  let(:required_params) do
    {
      id: "id123",
      verification_date: { date: Date.today },
      verification_requesting_system:
        {
          category_code: "Exchange"
        }
    }
  end

  let(:optional_params) do
    {
      address_verification_code: "verificationCode",
      dhs_g845_verification_code: "verificationCode",
      dhs_save_verification_code: "verificationCode",
      ffe_verification_code: "verificationCode",
      verification_authority_name: "Name",
      verification_authority_alpha_code: "alphaCode",
      verification_indicator: true,
      verification_inconsistency_indicator: false,
      verification_description_text: "Text",
      verification_inconsistency_text: "n/a",
      verification_category_codes: ["codes"],
      response_code: "responseCode",
      verification_status: { status_code: "1" }
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect(subject.call(optional_params).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
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
