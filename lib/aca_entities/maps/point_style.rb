module Maps
  class PointStyle < Dry::Struct

    # Mouse cursor to show on hover
    # attribute :cursor

    # Icon to show for the point geometry
    # attribute :icon

    # Defines the image map used for hit detection
    # attribute :shape

    # Rollover text
    attribute :title,     Types::String.meta(omittable: true)
  end
end
