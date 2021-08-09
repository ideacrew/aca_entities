# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::ResidentRole, dbclean: :after_each do

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

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: DateTime.now,
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

  let!(:input_params) do
    {
      is_applicant: true,
      is_active: true,
      bookmark_url: "/families/home",
      is_state_resident: true,
      residency_determined_at: nil,
      contact_method: "Paper and Electronic communications",
      language_preference: "English",
      local_residency_responses: event_response,
      lawful_presence_determination: lawful_presence_determination
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

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :lawful_presence_determination
                            end)
      end.to raise_error(Dry::Struct::Error, /:lawful_presence_determination is missing/)
    end
  end
end
