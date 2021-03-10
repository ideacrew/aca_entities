# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/verification_header_contract'

RSpec.describe AcaEntities::Contracts::VerificationHeaderContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      verification_date: Date.today,
      verified_by: 'Exchange',
      medicaid_chip_state: nil,
      medicaid_chip_county: nil,
      verification_type: 'SSN',
      verification_source: 'SSA',
      verification_status: 'FFEVerificationCode',
      verification_code: nil,
      response_code: nil
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
    context 'invalid input for verification_status' do
      before do
        @result = subject.call(input_params.merge(verification_status: 'Test'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to match(/must be one of: FFEVerificationCode/)
      end
    end

    context 'invalid input for verification_date' do
      before do
        @result = subject.call(input_params.merge(verification_date: nil))
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be filled')
      end
    end

    context 'invalid input for verification_source' do
      before do
        @result = subject.call(
          input_params.merge(
            {
              verification_status: 'DHS-G845VerificationCode',
              verification_source: 'SSA'
            }
          )
        )
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('invalid input for verification source code')
      end
    end
  end
end
