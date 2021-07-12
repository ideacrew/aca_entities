# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp StructuredAddress
      class StructuredAddress < Dry::Struct

        attribute :location_street, LocationStreet.optional.meta(omittable: true)
        attribute :address_secondary_unit_text, Types::String.optional.meta(omittable: true)
        attribute :location_city_name, Types::String.optional.meta(omittable: true)
        attribute :location_county_name, Types::String.optional.meta(omittable: true)
        attribute :location_county_code, Types::String.optional.meta(omittable: true)
        attribute :location_state_us_postal_service_code, Types::String.optional.meta(omittable: true)
        attribute :location_postal_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end