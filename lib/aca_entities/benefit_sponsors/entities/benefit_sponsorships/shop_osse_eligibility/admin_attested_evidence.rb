# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibility
        class AdminAttestedEvidence < Dry::Struct
          include AcaEntities::Eligible::Evidence
        end
      end
    end
  end
end
