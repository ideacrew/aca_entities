# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets RelationshipPricingUnit
    class TieredPricingUnit < BenefitMarkets::PricingUnit

      attribute :member_relationship_maps,  Types::Array.of(BenefitMarkets::MemberRelationshipMap).meta(omittable: false)

    end
  end
end