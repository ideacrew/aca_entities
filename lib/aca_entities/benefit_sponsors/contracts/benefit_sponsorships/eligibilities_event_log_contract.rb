# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      # contract for EligibilitiesEventLog
      class EligibilitiesEventLogContract < Dry::Validation::Contract
  
        params(EventLogContract.schema) do
          # Fields specific to the resource model can be included in this section, as illustrated below.
          # required(:custom_sponsorship_field).filled(:string)
        end
      end
    end
  end
end
