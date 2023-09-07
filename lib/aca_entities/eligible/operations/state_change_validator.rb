# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

module AcaEntities
  module Eligible
    # Validate state changes on eligibility models
    class StateChangeValidator
      PastState =
        Struct.new(:effective_on, :is_eligible, :from_state, :to_state, :event)
      CurrentState =
        Struct.new(
          :effective_on,
          :is_eligible,
          :from_state,
          :to_state,
          :event
        ) do
          attr_accessor :resource, :errors

          def validate
            # binding.irb
            validate_event
            validate_transition
            validate_is_eligible
          end

          def validate_event
            register_error { "event should be one of #{resource::EVENTS}" } unless resource::EVENTS.include?(event)
            register_error { "event name should be move_to_#{to_state}" } unless event == "move_to_#{to_state}".to_sym
          end

          def validate_transition
            if resource::STATE_TRANSITION_MAP[to_state]
              unless resource::STATE_TRANSITION_MAP[to_state].include?(
                from_state
              )
                register_error do
                  "Invalid from state #{from_state}. It should be one of #{resource::STATE_TRANSITION_MAP[to_state]}."
                end
              end
            else
              register_error do
                "Invalid to state #{to_state}. It should be one of #{resource::STATE_TRANSITION_MAP.keys}."
              end
            end
          end

          def validate_is_eligible
            is_eligible_status = resource::ELIGIBLE_STATUSES.include?(to_state)
            return if is_eligible.to_s == is_eligible_status.to_s

            register_error do
              "is_eligible should be #{is_eligible_status} for #{to_state} state"
            end
          end

          def register_error
            @errors.push(yield)
          end
        end

      attr_reader :past, :current, :errors

      def initialize(state_histories, resource)
        @resource = resource
        @errors = []
        latest_history = state_histories.last
        @current = build_current_state(latest_history)

        return unless state_histories.count > 1
        past_history = state_histories[-2]
        @past = build_past_state(past_history)
      end

      def validate
        validate_current
        validate_past_history
      end

      def validate_current
        current.resource = @resource
        current.errors = []
        current.validate
        @errors += current.errors unless current.errors.empty?
      end

      def validate_past_history
        return unless past
        return if past.to_state == current.from_state

        @errors << "Invalid state histories.
          Previous state history to_state #{past.to_state} not matching with current state history from_state #{current.from_state}."
      end

      private

      def build_current_state(history)
        history = history.to_h unless history.is_a?(Hash)
        CurrentState.new(*history.slice(*CurrentState.members).values)
      end

      def build_past_state(history)
        history = history.to_h unless history.is_a?(Hash)
        PastState.new(*history.slice(*PastState.members).values)
      end
    end
  end
end
