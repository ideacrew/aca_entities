# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Determinations::LawfulPresenceDeterminationContract do

  let(:event_response) do
    [
      {
        received_at: DateTime.now,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: DateTime.now,
        body: "request"
      }
    ]
  end

  let!(:required_params) do
    {
      vlp_verified_at: DateTime.now,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: "some status",
      citizenship_result: nil,
      qualified_non_citizenship_result: nil,
      aasm_state: "verification_successful",
      ssa_responses: event_response,
      ssa_requests: event_request,
      vlp_responses: event_response,
      vlp_requests: event_request
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :citizen_status })
      end
      # TODO: verify any required needed here
      it 'should return failure' do
        # expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        # expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        # expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end
  end
end
