# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets PricingUnit
    class PricingUnit < Dry::Struct

      attribute :name,                Types::Strict::String.meta(omittable: false)
      attribute :display_name,        Types::Strict::String.meta(omittable: false)
      attribute :order,               Types::Strict::Integer.meta(omittable: false)

    end
  end
end