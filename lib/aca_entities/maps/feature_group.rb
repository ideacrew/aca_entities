module Maps
  # A collection of Features with Filter applied and Style information
  class FeatureGroup < Dry::Struct
    attribute :key,       Types::Symbol.meta(omittable: false)
    attribute :title,     Types::String.meta(omittable: true)

    attribute :id_property_name,          Types::String.meta(omittable: false)
    attribute :geometry_property_name,    Types::String.meta(omittable: false)
    attribute :info_window_property_name, Types::String.meta(omittable: true)
    
    attribute :feature_collection,        Maps::GeoJson::FeatureCollection.meta(omittable: true)
    attribute :style_set,                 Types::Array.of(Maps::Types::StyleKind).meta(omittable: true)

  end
end
