# frozen_string_literal: true

module AcaEntities
  module Locations
    module GeoJson
      class Feature < Dry::Struct
        attribute :type, Types::String.default('Feature').freeze.meta(omittable: false)

        # Bounding Box information on the coordinate range. Values define shapes with edges that follow
        # lines of constant longitude, latitude, and elevation
        attribute :bbox, Types::Array.of(AcaEntities::Locations::GeoJson::Coordinate).optional.meta(omittable: true)
        attribute :geometry, AcaEntities::Locations::GeoJson::Geometry.meta(omittable: false)

        # Key/values attributes associated with this Feature
        attribute :properties, Types::Hash.meta(omittable: true)
      end
    end
  end
end
