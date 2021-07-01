# frozen_string_literal: true

module AcaEntities
  module Transistions
    # Entity for WorkflowStateTransition
    class WorkflowStateTransition < Dry::Struct

      attribute :from_state,      Types::Strict::String.meta(omittable: false)
      attribute :to_state,        Types::Strict::String.meta(omittable: false)
      attribute :transition_at,   Types::DateTime.meta(omittable: false)

      attribute :event,           Types::Strict::String.optional.meta(omittable: true)
      attribute :comment,         Types::Strict::String.optional.meta(omittable: true)
      attribute :reason,          Types::Strict::String.optional.meta(omittable: true)

      attribute :created_at,      Types::DateTime.optional.meta(omittable: true)
      attribute :updated_at,      Types::DateTime.optional.meta(omittable: true)
    end
  end
end
