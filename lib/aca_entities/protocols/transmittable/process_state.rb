# frozen_string_literal: true

require 'time'

module AcaEntities
  module Protocols
    module Transmittable
      # An individual process state that an object transitions through during its lifecycle
      class ProcessState < Dry::Struct

        # @!attribute [r] event
        # The event signal that triggered the change in this object's state
        # @return [String]
        attribute :event, Types::String.optional.meta(omittable: true)

        # @!attribute [r] message
        # A message that describes the event that triggered the change in this object's state
        # @return [String]
        attribute :message, Types::String.optional.meta(omittable: true)

        # @!attribute [r] state_key
        # The new state that the object transitioned to
        # @return [Symbol]
        attribute :state_key, Types::Symbol.meta(omittable: false)

        # @!attribute [r] started_at
        # The moment when this state transition occurred
        # @return [DateTime]
        attribute :started_at, Types::DateTime.meta(omittable: false)

        # @!attribute [r] ended_at
        # The moment when this state transition ended
        # @return [DateTime]
        attribute :ended_at, Types::DateTime.optional.meta(omittable: true)

        # @!attribute [r] time_in_state
        # The length of time that this object was in this state
        # @return [Integer]
        attribute :seconds_in_state, Types::Integer.meta(omittable: true)

      end
    end
  end
end
