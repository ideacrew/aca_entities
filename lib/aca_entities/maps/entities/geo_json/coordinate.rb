# frozen_string_literal: true

module AcaEntities
  module Maps
    module GeoJson

      # A position in space represented as a set of decimal numbers.  The first two
      # elements are longitude and latitude, or easting and northing.  Altitude or elevation
      # MAY be included as an optional third element.  Linear Referencing Measure may be
      # included as option fourth element
      class Coordinate < Dry::Struct

        # @!attribute [r] lon
        # Easting
        # @return [Types::Json::Decimal]
        attribute :lon,   Types::JSON::Decimal.meta(omittable: false)

        # @!attribute [r] lat
        # Northing
        # @return [Types::JSON::Decimal]
        attribute :lat,   Types::JSON::Decimal.meta(omittable: false)

        # @!attribute [r] lon
        # Altitude or elevation
        # @return [Types::JSON::Decimal]
        attribute :alt,  Types::JSON::Decimal.optional.meta(omittable: true)

        # @!attribute [r] m
        # Linear referencing measure
        # @return [Types::JSON::Decimal]
        attribute :m,     Types::JSON::Decimal.optional.meta(omittable: true)
      end

    end
  end
end
