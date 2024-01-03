# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for Event Log
    module EventLog
      def self.included(base)
        base.class_eval do
          transform_keys(&:to_sym)

          attribute :account_id, Types::String.optional.meta(omittable: true)
          attribute :subject_gid, Types::String.optional.meta(omittable: false)
          attribute :correlation_id, Types::String.optional.meta(omittable: false)
          attribute :message_id, Types::String.optional.meta(omittable: false)
          attribute :host_id, Types::String.optional.meta(omittable: false)
          attribute :payload, Types::Any.meta(omittable: true)

          attribute :event_category, Types::Strict::Symbol.meta(omittable: false)
          attribute :event_name, Types::String.optional.meta(omittable: false)
          attribute :event_time, Types::DateTime.optional.meta(omittable: false)

          attribute :session_detail,
                    AcaEntities::EventLogs::SessionDetail.optional.meta(omittable: false)
          attribute :monitored_event,
                    AcaEntities::EventLogs::MonitoredEvent.optional.meta(omittable: true)

          attribute :tags, Types::Array.optional.meta(omittable: true)
        end
      end
    end
  end
end
