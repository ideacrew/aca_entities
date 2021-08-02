# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/document_person_identification_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::DocumentPersonIdentificationContract, dbclean: :after_each do

  let(:required_params) { { identification_id: "MET00000000001887090" } }

  let(:optional_params) do
    { identification_category_text: "Exchange",
      identification_jurisdiction: "ME" }
  end

  let(:all_params) { required_params.merge(optional_params)}

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
