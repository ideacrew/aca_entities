# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class RelationshipPricingUnit < BenefitMarkets::PricingUnit
      transform_keys(&:to_sym)

      attribute :discounted_above_threshold,             Types::Integer.optional
      attribute :eligible_for_threshold_discount,        Types::Strict::Bool

    end
  end
end