# frozen_string_literal: true

require 'pry'
require 'spec_helper'
require 'aca_entities/contracts/transfer_header_contract'

RSpec.describe AcaEntities::Contracts::TransferHeaderContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      transfer_id: 'id',
      transfer_date: Date.today.to_datetime,
      number_of_referrals: 4,
      recipient_code: 'code',
      medicaid_chip_state: 'MA'
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

  context 'failure case' do
    context 'invalid input for transfer_date' do
      let(:result) { subject.call(input_params.merge(transfer_date: Date.today.to_date)) }

      it 'should return failure' do
        expect(result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(result.errors.messages.first.text).to eq('must be a date time')
      end
    end

    context 'invalid input for number_of_referrals' do
      let(:result) { subject.call(input_params.merge(number_of_referrals: 'TEST')) }

      it 'should return error message' do
        expect(result.errors.messages.first.text).to eq('must be an integer')
      end
    end
  end
end
