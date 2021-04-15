# frozen_string_literal: true

module AcaEntities
  module Products
    class Product < Dry::Struct
      attribute :market_place, Types::MarketPlaceKinds.meta(omittable: false)

      # For a particular market_place we only allow a specific
      # set of product_kinds(Types::ProductsByMarketPlaceKind).
      # Add rules around this in the Contract.
      attribute :product_kind, Types::ProductKind.meta(omittable: false)
    end
  end
end
