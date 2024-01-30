# frozen_string_literal: true

require "dry/validation"

module AcaEntities
  module EventLogs
    # contract for EventLog
    class EventLogContract < Dry::Validation::Contract

      params do
        optional(:account_id).maybe(:string)
        required(:subject_gid).filled(:string)
        required(:resource_gid).filled(:string)
        required(:correlation_id).filled(:string)
        required(:message_id).filled(:string)
        required(:host_id).maybe(:string)
        optional(:payload).maybe(:any)

        required(:event_category).filled(:symbol)
        required(:event_name).maybe(:string)
        required(:event_time).value(:date_time)

        optional(:session_detail).maybe(AcaEntities::EventLogs::SessionDetailContract.params)
        optional(:monitored_event).hash(AcaEntities::EventLogs::MonitoredEventContract.params)

        optional(:tags).maybe(:array)
      end
    end
  end
end
