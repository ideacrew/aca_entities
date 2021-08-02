# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::EligibilityBasisContract, dbclean: :after_each do

  let(:required_params) do
    {
      status_code: "Complete"
    }
  end

  let(:optional_params) do
    {
      status_indicator: true,
      status_valid_date_range:
        {
          start_date: { date: Date.today },
          end_date: { date: Date.today }
        },
      ineligibility_reason_text: "n/a",
      inconsistency_reason_text: "n/a",
      pending_reason_text: "n/a",
      determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" },
          activity_date: { date_time: DateTime.now }
        }
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
      let(:input_params) { required_params }

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
