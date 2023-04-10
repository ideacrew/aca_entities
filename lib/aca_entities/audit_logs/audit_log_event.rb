# frozen_string_literal: true

module AcaEntities
  module AuditLogs

    class AuditLogEvent < Dry::Struct
      attribute :subject_gid, Types::String.optional.meta(omittable: false)
      attribute :correlation_id, Types::String.optional.meta(omittable: false)
      attribute :event_category, Types::String.optional.meta(omittable: false)

      attribute :session_id, Types::String.optional.meta(omittable: true)
      attribute :account_id, Types::String.optional.meta(omittable: false)
      attribute :host_id, Types::String.optional.meta(omittable: false)

      attribute :trigger_response, Types::String.optional.meta(omittable: false)
      attribute :log_level, Types::Strict::Symbol
      attribute :severity, Types::Strict::Symbol
      attribute :event_time, AcaEntities::TimeStamp.optional.meta(omittable: true)
      attribute :tags, Types::Array
    end
  end
end
