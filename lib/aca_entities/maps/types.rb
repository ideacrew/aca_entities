# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Maps
    # custom types for maps
    module Types
      send(:include, Dry.Types())
      include Dry::Logic

      Css3ColorKind = Types::Coercible::String.enum(proc {  Maps::Css3Colors.keys.map(&:to_s).join(', ') })

      # Opacity range: 0.0 (fully transparent) to 1.0 (fully opaque)
      OpacityKind  = Types::JSON::Decimal.constrained(gteq:  0.0, lteq:  1.0)

      GeometryKind = Types::Coercible::String.enum('Point',
                                                   'LineString',
                                                   'Polygon',
                                                   'MultiPoint',
                                                   'MultiLineString',
                                                   'MultiPolygon')
      StyleKind    = Maps::FillStyle | Maps::LineStyle | Maps::PointStyle | Maps::TextStyle

      MapTypeIdKind = Types::Coercible::String.enum('HYBRID', 'ROADMAP', 'SATELLITE', 'TERRAIN')

      # @see: https://dry-rb.org/gems/dry-types/1.2/enum/
      # ZoomKind      = Types::Symbol.enum(world: 1, continent: 5, city: 10, streets: 15, buildings: 20)
      ZoomKind      = Types::Integer.constrained(gteq: 1, lteq: 20)

      LatitudeKind  = Types::Coercible::Float.constrained(gteq:  -90.0, lteq:  90.0)
      LongitudeKind = Types::Coercible::Float.constrained(gteq: -180.0, lteq: 180.0)

      FeatureKind = Types::Coercible::String.enum('Feature')

      # 0-dimensional Point and MultiPoint;
      # 1-dimensional curve LineString and MultiLineString;
      # 2-dimensional surface Polygon and MultiPolygon; and
      # heterogeneous GeometryCollection
      GeometryKind = Types::Coercible::String.enum('Point',
                                                   'MultiPoint',
                                                   'LineString',
                                                   'MultiLineString',
                                                   'Polygon',
                                                   'MultiPolygon',
                                                   'GeometryCollection')
    end
  end
end
