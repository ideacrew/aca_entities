# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Cv3 Entity for BenefitMarkets::PremiumTable
    class PremiumTable < Dry::Struct

      attribute :effective_period,    Types::Range.meta(omittable: false)
      attribute :rating_area,         Types::Bson.meta(omittable: false)
      attribute :premium_tuples,      Types::Array.of(BenefitMarkets::PremiumTuple).optional.meta(omittable: true)

      def member_premium(age)
        premium_tuples.detect { |p_tuple| p_tuple.age == age }
      end
    end
  end
end