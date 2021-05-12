# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Cv3 Entity for BenefitMarkets::PremiumTable
    class PremiumTable < Dry::Struct
      transform_keys(&:to_sym)

      # attribute :_id,                 Types::Bson
      attribute :effective_period,    Types::Range
      # attribute :rating_area_id,      Types::Bson
      attribute :premium_tuples,      Types::Array.of(BenefitMarkets::PremiumTuple).optional.meta(omittable: true)

      def member_premium(age)
        premium_tuples.detect { |p_tuple| p_tuple.age == age }
      end
    end
  end
end