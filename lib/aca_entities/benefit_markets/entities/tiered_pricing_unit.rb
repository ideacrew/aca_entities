# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class TieredPricingUnit < BenefitMarkets::PricingUnit
      transform_keys(&:to_sym)

      attribute :member_relationship_maps,  Types::Array.of(BenefitMarkets::MemberRelationshipMap)

    end
  end
end