# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets PremiumTuple
    class PremiumTuple < Dry::Struct

      attribute :age,    Types::Strict::Integer.meta(omittable: false)
      attribute :cost,   Types::Strict::Float.meta(omittable: false)

    end
  end
end