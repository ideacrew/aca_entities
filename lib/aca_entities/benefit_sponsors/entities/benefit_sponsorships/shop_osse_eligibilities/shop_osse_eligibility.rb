# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibilities
        # This is a feature specific entity defined to extend base eligibility class with additional fields and methods
        # Describe the allowed evidence, grant resource names using `evidence`, `grant` macros
        # Resource definitions are used to build the feature specific resource with contract validations
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
