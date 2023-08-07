# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibilities
        class ShopOsseEligibility < AcaEntities::Eligible::Eligibility
          # attribute :due_on # additional attributes
          evidence :shop_osse_evidence,
                   class_name:
                     "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::AdminAttestedEvidence"

          grant :contribution_subsidy_grant,
                class_name:
                  "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant"

          grant :min_employee_participation_relaxed_grant,
                class_name:
                  "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant"

          grant :min_fte_count_relaxed_grant,
                class_name:
                  "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant"

          grant :min_contribution_relaxed_grant,
                class_name:
                  "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant"

          grant :metal_level_products_restricted_grant,
                class_name:
                  "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant"
        end
      end
    end
  end
end
