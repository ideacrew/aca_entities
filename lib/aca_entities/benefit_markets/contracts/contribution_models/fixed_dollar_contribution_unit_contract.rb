# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module ContributionModels
      # Contract for FixedDollarContributionUnit
      class FixedDollarContributionUnitContract < BenefitMarkets::ContributionModels::ContributionUnitContract

        params do
          required(:default_contribution_amount).filled(:float)
        end

        rule(:default_contribution_amount) do
          if key && value && value < 0.0
            key.failure(text: "invalid default contribution amount for fixed dollar contribution unit", error: result.errors.to_h)
          end
        end
      end
    end
  end
end