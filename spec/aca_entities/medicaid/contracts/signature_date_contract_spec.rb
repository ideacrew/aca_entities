# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/signature_date_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::SignatureDateContract, dbclean: :after_each do

  it 'should inherit from DateContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::DateContract
  end

  let(:required_params) { { date: Date.today } }

  let(:optional_params) { {} }

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