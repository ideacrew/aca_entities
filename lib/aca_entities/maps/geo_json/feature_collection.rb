# frozen_string_literal: true

module Maps::GeoJson

  # GeoJSON is a format for encoding a variety of geographic data structures 
  # using JavaScript Object Notation (JSON)
  # A GeoJSON object may represent a:
  # region of space (a Geometry), 
  # spatially bounded entity (a Feature), or 
  # list of Features (a FeatureCollection)
  class FeatureCollection < Dry::Struct
    attribute :type,        Types::String.default("FeatureCollection").freeze.meta(omittable: false)
    attribute :features,    Types::Array.of(Maps::GeoJson::Feature).meta(omittable: true)
  end
end
