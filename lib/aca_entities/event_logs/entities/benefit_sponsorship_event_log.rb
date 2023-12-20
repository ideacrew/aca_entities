# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for BenefitSponsorship Event Log
    class BenefitSponsorshipEventLog < Dry::Struct
      include EventLog
    end
  end
end
