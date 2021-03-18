# frozen_string_literal: true

module Google::Maps
  class DataLayer < Dry::Struct
    attribute :features,  Types::Array.of(Maps::GeoJson::Feature).meta(omittable: false)
  end
end