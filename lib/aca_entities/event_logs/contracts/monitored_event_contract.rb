# frozen_string_literal: true

require "dry/validation"

module AcaEntities
  module EventLogs
    # contract for MonitoredEvent
    class MonitoredEventContract < Dry::Validation::Contract

      params do
        required(:account_id).filled(:string)
        required(:subject_hbx_id).filled(:string)
        required(:event_category).filled(:symbol)
        required(:event_time).value(:date_time)
        optional(:login_session_id).maybe(:string)
      end
    end
  end
end
