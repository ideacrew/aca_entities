# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Determinations::LawfulPresenceDetermination, dbclean: :after_each do

  let(:event_response) do
    [
      {
        received_at: Date.today,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: Date.today,
        body: "request"
      }
    ]
  end

  let!(:input_params) do
    {
      vlp_verified_at: Date.today,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: nil,
      citizenship_result: nil,
      qualified_non_citizenship_result: nil,
      aasm_state: "verification_successful",
      ssa_responses: event_response,
      ssa_requests: event_request,
      vlp_responses: event_response,
      vlp_requests: event_request
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end


