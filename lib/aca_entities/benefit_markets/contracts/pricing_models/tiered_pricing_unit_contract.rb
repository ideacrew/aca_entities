# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PricingModels
      # Contract for TieredPricingUnit
      class TieredPricingUnitContract < BenefitMarkets::PricingModels::PricingUnitContract

        params do
          required(:member_relationship_maps).array(:hash)
        end

        rule(:member_relationship_maps).each do
          if key? && value
            result = BenefitMarkets::PricingModels::MemberRelationshipMapContract.new.call(value)
            key.failure(text: "invalid member relationship maps for tiered pricing unit", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end