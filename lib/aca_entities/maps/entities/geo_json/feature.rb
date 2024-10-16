# frozen_string_literal: true

module AcaEntities
  module Maps
    module GeoJson
      # entity for Geojson feature
      class Feature < Dry::Struct
        attribute :type,        Types::String.default("Feature").freeze.meta(omittable: false)

        # Bounding Box information on the coordinate range. Values define shapes with edges that follow
        # lines of constant longitude, latitude, and elevation
        attribute :bbox,        Types::Array.of(Maps::GeoJson::Coordinate).optional.meta(omittable: true)
        attribute :geometry,    Maps::GeoJson::Geometry.meta(omittable: false)

        # Key/values attributes associated with this Feature
        attribute :properties,  Types::Hash.meta(omittable: true)
      end
    end
  end
end