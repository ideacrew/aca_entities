# frozen_string_literal: true

require 'dry-types'

module Maps::Types
  send(:include, Dry.Types())
  include Dry::Logic

  Css3ColorKind = Types::Coercible::String.enum( proc {  Maps::Css3Colors.keys.map(&:to_s).join(', ') } )

  # Opacity range: 0.0 (fully transparent) to 1.0 (fully opaque)
  OpacityKind  = Types::JSON::Decimal.constrained(gteq:  0.0, lteq:  1.0)

  GeometryKind = Types::Coercible::String.enum('Point',
                                               'LineString',
                                               'Polygon',
                                               'MultiPoint',
                                               'MultiLineString',
                                               'MultiPolygon')
  StyleKind    = Maps::FillStyle | Maps::LineStyle | Maps::PointStyle | Maps::TextStyle
end
