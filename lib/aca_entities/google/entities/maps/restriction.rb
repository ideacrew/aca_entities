module Google::Maps
  class Restriction < Dry::Struct
    attribute :lat_lng_bounds do
      attribute :north, Google::Maps::Types::LatitudeKind.meta(omittable: false)
      attribute :south, Google::Maps::Types::LatitudeKind.meta(omittable: false)
      attribute :east,  Google::Maps::Types::LongitudeKind.meta(omittable: false)
      attribute :west,  Google::Maps::Types::LongitudeKind.meta(omittable: false)
    end

    attribute :strictBounds, Types::Bool.meta(omittable: true)
  end
end