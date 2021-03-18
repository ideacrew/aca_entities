# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/referral_header_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::ReferralHeaderContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      referral_id: nil,
      referral_date: nil,
      evidence_documents_available: nil,
      referral_activity_reason: nil,
      referral_activity_eligibility: nil,
      referral_activity_status: nil,
      referral_activity_over_all_verification_status: nil
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
    context 'invalid input for referral_date' do
      before do
        @result = subject.call(input_params.merge(referral_date: Date.today.to_date))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('must be a date time')
      end
    end

    context 'invalid input for referral_activity_reason' do
      let(:error_msg) { 'must be one of: FullDetermination, WaitingPeriodException, GapFilling' }
      before do
        @result = subject.call(input_params.merge(referral_activity_reason: 'TEST'))
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq error_msg
      end
    end

    context 'invalid input for referral_activity_status' do
      let(:error_msg) do
        'must be one of: Initiated, Accepted, Rejected, ProvisionallyAccepted, Updated, PartiallyRejected'
      end

      before do
        @result = subject.call(input_params.merge(referral_activity_status: 'G845VerificationCode'))
      end

      it 'should return error message' do

        expect(@result.errors.messages.first.text).to eq(error_msg)
      end
    end
  end
end
