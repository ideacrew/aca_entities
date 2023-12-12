# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for Event Log
    module EventLog
      def self.included(base)
        base.class_eval do
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
  end
end
