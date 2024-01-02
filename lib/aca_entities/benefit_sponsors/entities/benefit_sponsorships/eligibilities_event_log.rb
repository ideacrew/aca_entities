# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      # Entity for Shop Eligibilities Event Log
      class EligibilitiesEventLog < Dry::Struct
        include EventLog
      end
    end
  end
end
