# frozen_string_literal: true

module AcaEntities
  module Products
    class FamilyRatedPremiums < Dry::Struct

      # RatingArea's ExchangeProvidedCode
      attribute :exchange_provided_code,          Types::String.optional.meta(omittable: true)
      attribute :primary_enrollee,                Types::Float.optional.meta(omittable: true)
      attribute :primary_enrollee_one_dependent,  Types::Float.optional.meta(omittable: true)
      attribute :primary_enrollee_many_dependent, Types::Float.optional.meta(omittable: true)
    end
  end
end
