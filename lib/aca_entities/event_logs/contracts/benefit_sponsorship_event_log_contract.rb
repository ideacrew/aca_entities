# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # contract for BenefitSponsorshipEventLog
    class BenefitSponsorshipEventLogContract < Dry::Validation::Contract

      params(EventLogContract.schema) do
        required(:custom_sponsorship_field).filled(:string)
      end
    end
  end
end
