module Maps
  class InfoWindow < Dry::Struct
    attribute :content,   Types::String.meta(omittable: false)
    attribute :max_width, Types::Integer.meta(omittable: true)
    attribute :z_index,   Types::Integer.meta(omittable: true)
  end
end
