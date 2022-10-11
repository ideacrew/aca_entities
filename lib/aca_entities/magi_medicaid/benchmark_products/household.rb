# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module BenchmarkProducts
      # Cv3 IAP Entity for BenchmarkProduct.
      class Household < Dry::Struct
        attribute :household_hbx_id, Types::String.meta(omittable: false)
        attribute :type_of_household, Types::String.meta(omittable: false)
        attribute :household_ehb_premium, ::AcaEntities::Types::Money.meta(omittable: false)
        attribute :household_health_ehb_premium, ::AcaEntities::Types::Money.meta(omittable: false)
        attribute :health_product_reference, AcaEntities::Products::ProductReference.meta(omittable: false)

        attribute :household_dental_ehb_premium, ::AcaEntities::Types::Money.optional.meta(omittable: true)
        attribute :dental_product_reference, AcaEntities::Products::ProductReference.optional.meta(omittable: true)

        attribute :members, Types::Array.of(Member).meta(omittable: false)
      end
    end
  end
end
