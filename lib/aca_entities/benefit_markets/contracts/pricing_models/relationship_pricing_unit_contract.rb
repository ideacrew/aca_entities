# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PricingModels
      # Contract for RelationshipPricingUnit
      class RelationshipPricingUnitContract < BenefitMarkets::PricingModels::PricingUnitContract

        params do
          optional(:discounted_above_threshold).maybe(:integer)
          required(:eligible_for_threshold_discount).filled(:bool)
        end

        rule(:discounted_above_threshold) do
          key.failure(text: "invalid discount threshold for relationship pricing unit", error: result.errors.to_h) if key && value && value < 0
        end
      end
    end
  end
end