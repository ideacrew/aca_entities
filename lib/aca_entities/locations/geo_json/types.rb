# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Locations
    module GeoJson
      module Types
        send(:include, Dry.Types)
        include Dry::Logic

        FeatureKind = Types::Coercible::String.enum('Feature')

        # 0-dimensional Point and MultiPoint;
        # 1-dimensional curve LineString and MultiLineString;
        # 2-dimensional surface Polygon and MultiPolygon; and
        # heterogeneous GeometryCollection
        GeometryKind =
          Types::Coercible::String.enum(
            'Point',
            'MultiPoint',
            'LineString',
            'MultiLineString',
            'Polygon',
            'MultiPolygon',
            'GeometryCollection'
          )
      end
    end
  end
end
