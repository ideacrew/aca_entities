# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Eligible
    # Validate state changes on eligibility models
    class StateChangeValidator
      PastState = Struct.new(:effective_on, :is_eligible, :from_state, :to_state, :event)
      CurrentState = Struct.new(:effective_on, :is_eligible, :from_state, :to_state, :event) do
        attr_accessor :resource, :errors

        def validate
          validate_event
          validate_transition
          validate_is_eligible
        end

        def validate_event
          errors << "event should be one of #{resource::EVENTS}" unless resource::EVENTS.include?(event)
          errors << "event name should be move_to_#{to_state}" unless event == "move_to_#{to_state}".to_sym
        end

        def validate_transition
          errors << "Invalid state transition" unless resource::STATE_TRANSITION_MAP[to_state]&.include?(from_state)
        end

        def validate_is_eligible
          if resource::ELIGIBLE_STATUSES.include?(to_state)
            validate_eligible_status(true)
          else
            validate_eligible_status(false)
          end
        end

        def validate_eligible_status(expected_status)
          return if is_eligible.to_s == expected_status.to_s
          errors << "is_eligible should be #{expected_status} for #{expected_status ? 'eligible' : 'ineligible'} status"
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

        errors << "Past state history to_state should match with latest state history from_state" unless past.to_state == current.from_state
      end

      private

      def build_current_state(history)
        CurrentState.new(*history.slice(*CurrentState.members).values)
      end

      def build_past_state(history)
        PastState.new(*history.slice(*PastState.members).values)
      end
    end
  end
end
