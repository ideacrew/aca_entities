# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Verifications::VerificationTypeHistoryElementContract do

  let(:required_params) do
    { verification_type: "Social Security Number",
      action: "SSA Hub Request",
      modifier: "Enroll App",
      update_reason: "Hub request",
      event_response_record: {},
      event_request_record: {} }
  end

  let(:optional_params) do
    { verification_type: nil,
      action: nil,
      modifier: nil,
      update_reason: nil }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
      @result_with_nil_values = subject.call(optional_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
      expect(@result_with_nil_values.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
      expect(@result_with_nil_values.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(event_response_record: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end
    end
  end
end
