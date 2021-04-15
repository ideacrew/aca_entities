# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class FixedPercentContributionUnit < BenefitMarkets::ContributionUnit
      transform_keys(&:to_sym)

      attribute :default_contribution_factor,  Types::Strict::Float
      attribute :minimum_contribution_factor,  Types::Strict::Float

    end
  end
end