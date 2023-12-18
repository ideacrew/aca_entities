# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # contract for BenefitSponsorshipEventLog
    class BenefitSponsorshipEventLogContract < Dry::Validation::Contract

      params(EventLogContract.schema) do
        # Fields specific to the resource model can be included in this section, as illustrated below.
        # required(:custom_sponsorship_field).filled(:string)
      end
    end
  end
end
