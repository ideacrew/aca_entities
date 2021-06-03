# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets FixedDollarContributionUnit
    class FixedDollarContributionUnit < BenefitMarkets::ContributionUnit

      attribute :default_contribution_amount,    Types::Strict::Float.meta(omittable: false)

    end
  end
end