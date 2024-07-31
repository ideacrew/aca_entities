# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_policy_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::InsurancePolicyContract do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      member:
        {
          chip_identification: { identification_id: "id123" },
          medicaid_identification: { identification_id: "id123" }
        },
      policy_id: { identification_id: "MET00000000001887090" },
      premium:
        {
          amount: 0.00,
          aptc_amount: 0.00,
          subscriber_amount: 0.00
        },
      source_code: "sourceCode",
      applied_effective_date_range:
        {
          start_date: { date: Date.today },
          end_date: { date: Date.today }
        }
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with unexpected parameters' do

      let(:input_params) { { cat: "meow" } }

      it { expect(subject.call(input_params)[:result]).to eq(nil) }
    end
  end

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
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
