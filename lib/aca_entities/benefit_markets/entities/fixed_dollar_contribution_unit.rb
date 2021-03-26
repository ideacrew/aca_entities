# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class FixedDollarContributionUnit < BenefitMarkets::ContributionUnit
      transform_keys(&:to_sym)

      attribute :default_contribution_amount,                      Types::Strict::Float

    end
  end
end