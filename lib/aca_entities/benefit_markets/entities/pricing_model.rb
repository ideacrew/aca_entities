# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class PricingModel < Dry::Struct
      transform_keys(&:to_sym)

      # attribute :_id,                            Types::Bson
      attribute :name,                           Types::Strict::String
      attribute :price_calculator_kind,          Types::Strict::String
      attribute :product_multiplicities,         Types::Strict::Array
      attribute :member_relationships,           Types::Array.of(BenefitMarkets::MemberRelationship)
      attribute :pricing_units,                  Types::Array.of(BenefitMarkets::PricingUnit)

    end
  end
end