# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/medicaid_magi_eligibility_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::MedicaidMagiEligibilityContract do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      date_range:
        {
          start_date: { date: Date.today },
          end_date: { date: Date.today }
        },
      eligibility_determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" }
        },
      eligibility_indicator: false,
      eligibility_reason_text: "a-reason",
      income_eligibility_basis: { status_code: "Pending" }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

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
