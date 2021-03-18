module Maps
  class Feature < Dry::Struct

    attribute :key,     Types::Symbol.meta(omittable: false)
    attribute :source,  Source.meta(omittable: false)
    attribute :filter,  StyleSet.meta(omittable: true)
    attribute :info_window, Maps::InfoWindow.optional.meta(omittable: true)
  end
end
