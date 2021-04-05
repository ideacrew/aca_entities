# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/basis_for_outcome_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::BasisForOutcomeContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { is_blind_or_disabled: true,
      attested_long_term_care: false }
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
      let(:input_params) { {} }

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
