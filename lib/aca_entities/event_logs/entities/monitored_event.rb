# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for Monitored Log
    class MonitoredEvent < Dry::Struct
      transform_keys(&:to_sym)

      attribute :market_kind, Types::String.optional.meta(omittable: false)
      attribute :account_id, Types::String.optional.meta(omittable: false)
      attribute :subject_hbx_id, Types::String.optional.meta(omittable: false)
      attribute :event_category, Types::Strict::Symbol.meta(omittable: false)
      attribute :event_time, Types::DateTime.optional.meta(omittable: false)  
      attribute :login_session_id, Types::String.optional.meta(omittable: true)
    end
  end
end
