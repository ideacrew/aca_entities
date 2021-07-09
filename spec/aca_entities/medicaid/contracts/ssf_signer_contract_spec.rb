# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/ssf_signer_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::SsfSignerContract, dbclean: :after_each do

  let(:required_params) { { role_reference: { ref: "a-person-id" } } }

  let(:optional_params) do
    { signature: { date_time: { date: DateTime.now.to_date } },
      ssf_attestation: ssf_attestation }
  end

  let(:ssf_attestation) do
    {
      non_perjury_indicator: true,
      not_incarcerated_indicators: [{ metadata: nil, value: true }],
      information_changes_indicator: false
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
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