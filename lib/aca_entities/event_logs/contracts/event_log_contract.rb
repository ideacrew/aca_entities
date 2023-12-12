# frozen_string_literal: true

require "dry/validation"

module AcaEntities
  module EventLogs
    # contract for EventLog
    class EventLogContract < Dry::Validation::Contract

      params do
        required(:subject_gid).filled(:string)
        required(:correlation_id).filled(:string)
        required(:event_category).filled(:symbol)

        optional(:session_id).maybe(:string)
        optional(:account_id).maybe(:string)
        required(:host_id).maybe(:string)

        required(:trigger).maybe(:string)
        required(:response).maybe(:string)

        optional(:log_level).filled(:symbol)
        optional(:severity).filled(:symbol)
        required(:event_time).value(:date_time)
        optional(:tags).maybe(:array)
      end
    end
  end
end
