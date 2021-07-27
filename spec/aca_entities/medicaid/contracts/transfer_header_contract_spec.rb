# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/transfer_header_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::TransferHeaderContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) { { transfer_activity: transfer_activity } }

  let(:optional_params) { { recipient_state_code: 'ME' } }

  let(:all_params) { required_params.merge(optional_params) }

  let(:transfer_activity) do
    {
      transfer_id: { identification_id: '2163565' },
      transfer_date: { date_time: DateTime.now },
      number_of_referrals: 1,
      recipient_code: 'MedicaidCHIP',
      state_code: 'ME'
    }
  end

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
