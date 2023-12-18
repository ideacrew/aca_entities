# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for Person Event Log
    class PersonEventLog < Dry::Struct
      include EventLog
    end
  end
end
