# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibility
        class Eligibility < Dry::Struct
          include Eligible
          include AcaEntities::Eligible::Eligibility

          # attribute :due_on # additional attributes
          evidence :shop_osse_evidence,
                   class_name:
                     'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::AdminAttestedEvidence'
          grant :shop_osse_grant,
                class_name:
                  'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'
        end
      end
    end
  end
end
