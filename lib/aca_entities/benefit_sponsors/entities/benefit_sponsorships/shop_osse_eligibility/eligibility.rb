# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      module ShopOsseEligibility
        class Eligibility < AcaEntities::Eligible::Eligibility
          include AcaEntities::Eligible::Eligible

          # attribute :due_on # additional attributes
          evidence :shop_osse_evidence,
                   class_name:
                     'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::AdminAttestedEvidence'

          grant :contribution_subsidy_grant,
                class_name:
                'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'

          grant :min_employee_participation_relaxed_grant,
                class_name:
                'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'

          grant :min_fte_count_relaxed_grant,
                class_name:
                'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'

          grant :min_contribution_relaxed_grant,
                class_name:
                'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'

          grant :metal_level_products_restricted_grant,
                class_name:
                'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant'

        end
      end
    end
  end
end
