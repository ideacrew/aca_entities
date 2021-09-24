# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check/contracts/requested_insurance_period_contract'

RSpec.describe AcaEntities::Medicaid::MecCheck::Contracts::RequestedInsurancePeriodContract, type: :model do

  let(:required_params) do
    {
      start_date: (Time.now - 604_800).to_date,
      end_date: Date.today
    }
  end

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
  end
end
