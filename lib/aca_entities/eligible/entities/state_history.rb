# frozen_string_literal: true

module AcaEntities
  module Eligible
    # Entity for StateHistory
    # Intended to keep track state based historical snapshots of the record with eligibility.
    class StateHistory < Dry::Struct
      attribute? :id, Types::Coercible::String.optional.meta(omittable: true)

      # @!attribute [r] effective_on
      # Effective date of the eligibility
      # @return [Date]
      attribute :effective_on, Types::Date.meta(omittable: false)

      # @!attribute [r] is_eligible
      # Determination made based on the current state
      # @return [Boolean]
      attribute :is_eligible, Types::Bool.optional.meta(omittable: false)

      # @!attribute [r] from_state
      # Initial state of the record
      # @return [String]
      attribute :from_state, Types::Strict::Symbol.meta(omittable: false)

      # @!attribute [r] to_state
      # Final state of the record
      # @return [String]
      attribute :to_state, Types::Strict::Symbol.meta(omittable: false)

      # @!attribute [r] transition_at
      # Transition time
      # @return [DateTime]
      attribute :transition_at, Types::DateTime.meta(omittable: false)

      # @!attribute [r] event
      # Event upon which state transition occured
      # @return [String]
      attribute :event, Types::Strict::Symbol.optional.meta(omittable: false)

      # @!attribute [r] comment
      # An optional account of the state transition
      # @return [String]
      attribute :comment, Types::Strict::String.optional.meta(omittable: true)

      # @!attribute [r] reason
      # StateHistory reason
      # @return [String]
      attribute :reason, Types::Strict::String.optional.meta(omittable: true)

      # @!attribute [r] timestamp
      # Timestamp of the resource ie. submitted, created or modified time of the resource
      # @return [Timestamp]
      attribute :timestamp,
                AcaEntities::TimeStamp.optional.meta(omittable: true)

      alias current_state to_state
    end
  end
end
