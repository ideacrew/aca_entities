# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # The current state of a process and the history of its state transitions
      class ProcessStatus < Dry::Struct

        # @!attribute [r] initial_state_key
        # The status value to set for this process when it's initialized
        # @return [Symbol]
        attribute :initial_state_key, Types::Symbol.meta(omittable: true)

        # @!attribute [r] latest_state
        # The current state of the process
        # @return [Symbol]
        attribute :latest_state, Types::Symbol.meta(omittable: true)

        # @!attribute [r] states
        # The list of state transitions that have occurred during the process
        # @return [Array<AcaEntities::Protocols::Transmittable::ProcessState>]
        attribute :states, Types::Array.of(AcaEntities::Protocols::Transmittable::ProcessState).meta(omittable: true)

        # @!attribute [r] elapsed_time
        # The total length of time that the process has been running
        # @return [Integer]
        attribute? :elapsed_time, Types::Integer.meta(omittable: true)

        def initialize(args)
          @elapsed_time = sum_process_state_times
          @state = latest_process_state[:key]
          super
        end

        # Returns the most recent {ProcessState} instance based on started time
        # @return [ProcessState]
        def latest_process_state
          states.order_by(:transitioned_at.desc).limit(1).first[:state]
        end

        def sum_process_state_times
          @elapsed_time = if states.any?
                            states.reduce(0) { |process_state, summed_time| summed_time + process_state.time_in_state.to_i }
                          else
                            0
                          end
        end

      end
    end
  end
end