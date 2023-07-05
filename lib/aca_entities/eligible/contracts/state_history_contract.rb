# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::StateHistory
    class StateHistoryContract < Dry::Validation::Contract
      params do
        required(:effective_on).filled(:date)
        required(:is_eligible).filled(:bool)
        required(:from_state).filled(:string)
        required(:to_state).filled(:string)
        required(:transition_at).filled(:date_time)
        optional(:event).maybe(:string)
        optional(:comment).maybe(:string)
        optional(:reason).maybe(:string)
        optional(:timestamps).filled(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end
    end
  end
end
