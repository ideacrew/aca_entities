# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/income_compatibility_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::IncomeCompatibilityContract do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      verification_indicator: true,
      inconsistency_reason_text: "123",
      compatibility_determination: compatibility_determination,
      verification_method: "1"
    }
  end

  let(:compatibility_determination) do
    {
      activity_identification: { identification_id: "MET00000000001887090" },
      activity_date: { date_time: DateTime.now }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

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
