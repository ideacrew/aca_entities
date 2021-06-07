# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module ContributionModels
      # Contract for PercentWithCapContributionUnit
      class PercentWithCapContributionUnitContract < BenefitMarkets::ContributionModels::ContributionUnitContract

        params do
          required(:default_contribution_factor).filled(:float)
          required(:default_contribution_cap).filled(:float)
          required(:minimum_contribution_factor).filled(:float)
        end

        rule(:default_contribution_factor) do
          if key && value && !(value >= 0.0 && value <= 1.0)
            key.failure(text: "invalid default contribution amount for fixed dollar contribution unit",
                        error: result.errors.to_h)
          end
        end

        rule(:default_contribution_cap) do
          if key && value && value < 0.00
            key.failure(text: "invalid default contribution amount for fixed dollar contribution unit",
                        error: result.errors.to_h)
          end
        end

        rule(:minimum_contribution_factor) do
          if key && value && !(value >= 0.0 && value <= 1.0)
            key.failure(text: "invalid default contribution amount for fixed dollar contribution unit",
                        error: result.errors.to_h)
          end
        end
      end
    end
  end
end