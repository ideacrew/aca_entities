# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets FixedPercentContributionUnit
    class FixedPercentContributionUnit < BenefitMarkets::ContributionUnit

      attribute :default_contribution_factor,  Types::Strict::Float.meta(omittable: false)
      attribute :minimum_contribution_factor,  Types::Strict::Float.meta(omittable: false)

    end
  end
end