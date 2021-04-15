# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module SponsoredBenefits
      # contract for SponsorContribution
      class SponsorContributionContract < Dry::Validation::Contract

        params do
          required(:contribution_levels).array(:hash)
        end

        rule(:contribution_levels).each do
          if key? && value
            result = ::BenefitSponsors::SponsoredBenefits::ContributionLevelContract.new.call(value)
            key.failure(text: "invalid contribution level", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end