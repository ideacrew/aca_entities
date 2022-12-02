# frozen_string_literal: true

module AcaEntities
  module Locations
    module GeoJson
      class Geometry < Dry::Struct
        attribute :type, AcaEntities::Locations::GeoJson::Types::GeometryKind.meta(omittable: false)
        attribute :coordinates,
                  Types::Array
                    .of(AcaEntities::Locations::GeoJson::Coordinate)
                    .default([].freeze)
                    .optional
                    .meta(omittable: true)
      end
    end
  end
end
