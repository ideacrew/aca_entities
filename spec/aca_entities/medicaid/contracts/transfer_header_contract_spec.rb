# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/transfer_header_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::TransferHeaderContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      recipient_state_code: "ME",
      transfer_activity: {
        transfer_id: {identification_id: '2163565'},
        transfer_date: {date_time: DateTime.now},
        number_of_referrals: 1,
        recipient_code: 'MedicaidCHIP',
        state_code: 'ME'
      }
    }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end
end
