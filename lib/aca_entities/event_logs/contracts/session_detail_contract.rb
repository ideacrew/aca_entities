# frozen_string_literal: true

require "dry/validation"

module AcaEntities
  module EventLogs
    # contract for SessionDetails
    class SessionDetailContract < Dry::Validation::Contract

      params do
        required(:session_id).filled(:string)
        required(:login_session_id).filled(:string)
        required(:portal).filled(:string)
      end
    end
  end
end
