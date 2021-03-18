module Maps
  class Source < Dry::Struct
    attribute :key,         Types::Symbol.meta(omittable: false)
    attribute :path_name,   Types::String.meta(omittable: false)
  end
end
