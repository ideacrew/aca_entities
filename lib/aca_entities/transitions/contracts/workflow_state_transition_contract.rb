# frozen_string_literal: true

module AcaEntities
  module Transistions
    # Entity for WorkflowStateTransitionContract
    class WorkflowStateTransitionContract < Dry::Validation::Contract

      params do
        required(:from_state).filled(:string)
        required(:to_state).filled(:string)
        required(:transition_at).filled(:date_time)

        optional(:event).maybe(:string)
        optional(:comment).maybe(:string)
        optional(:reason).maybe(:string)

        optional(:created_at).maybe(:date_time)
        optional(:updated_at).maybe(:date_time)
      end
    end
  end
end
