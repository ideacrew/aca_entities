# frozen_string_literal: true

module Maps::GeoJson

  class Geometry < Dry::Struct
    attribute :type,        Maps::GeoJson::Types::GeometryKind.meta(omittable: false)
    attribute :coordinates, Types::Array.of(Maps::GeoJson::Coordinate).default([].freeze).optional.meta(omittable: true)
  end

end
