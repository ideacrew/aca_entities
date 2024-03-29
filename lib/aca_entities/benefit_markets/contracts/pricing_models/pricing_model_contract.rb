# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PricingModels
      # Contract for PricingModel
      class PricingModelContract < Dry::Validation::Contract

        params do
          required(:name).filled(:string)
          required(:price_calculator_kind).filled(:string)
          required(:product_multiplicities).array(:symbol)
          required(:pricing_units).array(BenefitMarkets::PricingModels::PricingUnitContract.params)
          required(:member_relationships).array(BenefitMarkets::PricingModels::MemberRelationshipContract.params)
        end

        rule(:pricing_units).each do
          if key && value && ![BenefitMarkets::PricingUnit, BenefitMarkets::RelationshipPricingUnit,
                               BenefitMarkets::TieredPricingUnit].include?(value.class)
            if value.is_a?(Hash)
              result = BenefitMarkets::PricingModels::PricingUnitContract.new.call(value)
              key.failure(text: "invalid pricing unit for pricing model", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid pricing unit. Expected an hash or pricing unit entity")
            end
          end
        end

        rule(:member_relationships).each do
          if key && value
            result = BenefitMarkets::PricingModels::MemberRelationshipContract.new.call(value)
            key.failure(text: "invalid member relationship for pricing model", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end