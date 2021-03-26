# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module ContributionModels
      # Contract for FixedPercentContributionUnit
      class FixedPercentContributionUnitContract < BenefitMarkets::ContributionModels::ContributionUnitContract

        params do
          required(:default_contribution_factor).filled(:float)
          required(:minimum_contribution_factor).filled(:float)
        end

        rule(:default_contribution_factor) do
          if key? && value && !(value >= 0.0 && value <= 1.0)
            key.failure(text: "invalid default contribution factor for fixed percent contribution unit",
                        error: result.errors.to_h)
          end
        end

        rule(:minimum_contribution_factor) do
          if key? && value && !(value >= 0.0 && value <= 1.0)
            key.failure(text: "invalid minimum contribution facotr for fixed percent contribution unit",
                        error: result.errors.to_h)
          end
        end
      end
    end
  end
end