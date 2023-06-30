module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibility
        class Grant < Dry::Struct
          include AcaEntities::Eligible::Grant
        end
      end
    end
  end
end
