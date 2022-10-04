# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module BenchmarkProducts
      # Cv3 IAP Entity for BenchmarkProduct.
      class BenchmarkProduct < Dry::Struct
        attribute :effective_date, Types::Date.meta(omittable: false)
        attribute :primary_rating_address, ::AcaEntities::Locations::Address.meta(omittable: false)
        attribute :exchange_provided_code, Types::String.meta(omittable: false)
        attribute :household_group_ehb_premium, ::AcaEntities::Types::Money.meta(omittable: false)
        attribute :households, Types::Array.of(Household).meta(omittable: false)
      end
    end
  end
end
