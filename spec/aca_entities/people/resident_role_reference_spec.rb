# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::ResidentRoleReference, dbclean: :after_each do

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

  let(:input_params) do
    {
      is_active: true,
      is_applicant: true,
      is_state_resident: true,
      residency_determined_at: Date.today
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
                              k == :is_applicant
                            end)
      end.to raise_error(Dry::Struct::Error, /:is_applicant is missing/)
    end
  end

  describe 'with nil is_active' do
    it "should not raise an error" do
      input_params.merge(is_active: nil)
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
