# frozen_string_literal: true

require "dry/validation"

module AcaEntities
  module EventLogs
    # contract for EventLog
    class EventLogContract < Dry::Validation::Contract

      params do
        optional(:account_id).maybe(:string)
        required(:subject_gid).filled(:string)
        required(:correlation_id).filled(:string)
        required(:message_id).filled(:symbol)
        required(:host_id).maybe(:string)

        required(:event_category).filled(:symbol)
        required(:event_time).value(:date_time)

        required(:session_detail).hash(AcaEntities::EventLogs::SessionDetailContract.params)

        required(:trigger).maybe(:string)
        optional(:tags).maybe(:array)
      end
    end
  end
end
