# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    class SponsorContribution < Dry::Struct
      transform_keys(&:to_sym)

      attribute :contribution_levels, Types::Array.of(BenefitSponsors::ContributionLevel)
    end
  end
end