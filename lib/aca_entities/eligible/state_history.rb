module AcaEntities
  module Eligible
    # Entity for StateHistory
    class StateHistory < Dry::Struct
      attribute :effective_on, Types::Date.meta(omittable: false)
      attribute :is_eligible, Types::Bool.optional.meta(omittable: false) # helper value when current state value is satisfied

      # attribute :current_state, Types::String.meta(omittable: true) # replaces aasm_state attribute

      attribute :from_state, Types::Strict::String.meta(omittable: false)
      attribute :to_state, Types::Strict::String.meta(omittable: false)
      attribute :transition_at, Types::DateTime.meta(omittable: false)

      attribute :event, Types::Strict::String.optional.meta(omittable: true)
      attribute :comment, Types::Strict::String.optional.meta(omittable: true)
      attribute :reason, Types::Strict::String.optional.meta(omittable: true)

      # attribute :workflow_state_transitions, Types::Array.of(AcaEntities::Transitions::WorkflowStateTransition).meta(omittable: false)
      attribute :timestamp,
                AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
