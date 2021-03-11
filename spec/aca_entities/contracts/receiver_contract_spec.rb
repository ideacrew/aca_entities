# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/receiver_contract'

RSpec.describe AcaEntities::Contracts::ReceiverContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      receiver_code: nil,
      receiver_medicaid_chip_state: nil,
      receiver_medicaid_chip_county: nil
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
