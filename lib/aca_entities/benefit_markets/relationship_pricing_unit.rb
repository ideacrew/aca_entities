# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets RelationshipPricingUnit
    class RelationshipPricingUnit < BenefitMarkets::PricingUnit

      attribute :discounted_above_threshold,             Types::Integer.optional.meta(omittable: true)
      attribute :eligible_for_threshold_discount,        Types::Strict::Bool.meta(omittable: false)

    end
  end
end