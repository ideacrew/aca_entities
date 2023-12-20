# frozen_string_literal: true

require "spec_helper"

module AcaEntities
  module Eligible
    # entity class for DummyEvidence
    class DummyEvidence < Dry::Struct

      INELIGIBLE_STATUSES = %i[initial denied].freeze
      ELIGIBLE_STATUSES = %i[approved].freeze
      EVENTS = %i[move_to_initial move_to_approved move_to_denied].freeze

      STATE_TRANSITION_MAP = {
        initial: [:initial],
        approved: [:initial, :denied],
        denied: [:initial, :approved]
      }.freeze
    end
  end
end

RSpec.describe AcaEntities::Eligible::StateChangeValidator do

  let(:resource_name) do
    AcaEntities::Eligible::DummyEvidence
  end

  let(:current) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :initial,
      to_state: :approved,
      event: :move_to_approved,
      transition_at: DateTime.now
    }
  end

  context "with single state history" do
    context 'when valid' do

      it 'should validate with no errors' do
        validator = described_class.new([current], resource_name)
        validator.validate
        expect(validator.errors).to be_empty
      end
    end

    context 'when invalid' do
      let(:current) do
        {
          effective_on: Date.today,
          is_eligible: true,
          from_state: :approved,
          to_state: :approved,
          event: :move_to_initial,
          transition_at: DateTime.now
        }
      end

      it 'should fail with errors' do
        validator = described_class.new([current], resource_name)
        validator.validate
        expect(validator.errors).to be_present
        expect(validator.errors).to include("event name should be move_to_#{current[:to_state]}")
        expect(validator.errors).to include("Invalid from state approved. It should be one of [:initial, :denied].")
      end
    end
  end
end
