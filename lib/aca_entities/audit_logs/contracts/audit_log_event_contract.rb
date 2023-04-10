# frozen_string_literal: true

module AcaEntities
  module AuditLogs
    # contract for Audit Log Event
    class AuditLogEventContract < Dry::Validation::Contract

      params do
        required(:subject_gid).maybe(:string)
        required(:correlation_id).maybe(:string)
        required(:event_category).maybe(:string)

        required(:session_id).maybe(:string)
        required(:account_id).maybe(:string)
        required(:host_id).maybe(:string)

        required(:trigger_response).maybe(:string)
        required(:log_level).filled(:symbol)
        required(:severity).filled(:symbol)
        required(:event_time).hash(AcaEntities::Contracts::TimeStampContract.params)
        required(:tags).filled(:array)
      end
    end
  end
end
