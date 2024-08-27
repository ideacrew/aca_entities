# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for BenefitMArkets PremiumValueProduct
    class PremiumValueProduct < Dry::Struct
      transform_keys(&:to_sym)
      include AcaEntities::Eligible::Eligible

      eligibility :pvp_eligibility, class_name: "AcaEntities::BenefitMarkets::PvpEligibilities::PvpEligibility"

      attribute :hios_id,           Types::Strict::String.meta(omittable: false)
      attribute :active_year,       Types::Integer.meta(omittable: false)
      attribute :product_id,        Types::String.meta(omittable: false)
      attribute :rating_area_id,    Types::String.meta(omittable: false)
    end
  end
end