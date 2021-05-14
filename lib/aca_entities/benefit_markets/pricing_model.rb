# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets PricingModel
    class PricingModel < Dry::Struct

      attribute :name,                           Types::Strict::String.meta(omittable: false)
      attribute :price_calculator_kind,          Types::Strict::String.meta(omittable: false)
      attribute :product_multiplicities,         Types::Strict::Array.meta(omittable: false)
      attribute :member_relationships,           Types::Array.of(BenefitMarkets::MemberRelationship).meta(omittable: false)
      attribute :pricing_units,                  Types::Array.of(BenefitMarkets::PricingUnit).meta(omittable: false)

    end
  end
end