# frozen_string_literal: true

module AcaEntities
  module AuditLogs
    # Entity for Audit Log Event
    class AuditLogEvent < Dry::Struct
      transform_keys(&:to_sym)

      attribute :subject_gid, Types::String.optional.meta(omittable: false)
      attribute :correlation_id, Types::String.optional.meta(omittable: false)
      attribute :event_category, Types::Strict::Symbol.meta(omittable: false)

      attribute :session_id, Types::String.optional.meta(omittable: true)
      attribute :account_id, Types::String.optional.meta(omittable: true)
      attribute :host_id, Types::String.optional.meta(omittable: false)

      attribute :trigger, Types::String.optional.meta(omittable: false)
      attribute :response, Types::String.optional.meta(omittable: false)
      attribute :log_level, Types::Strict::Symbol.meta(omittable: true)
      attribute :severity, Types::Strict::Symbol.meta(omittable: true)
      attribute :event_time, Types::DateTime.optional.meta(omittable: false)
      attribute :tags, Types::Array.optional.meta(omittable: true)
    end
  end
end