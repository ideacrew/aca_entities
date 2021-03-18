module Maps
  class FillStyle < Dry::Struct
    attribute :color,     Maps::Types::Css3ColorKind.meta(omittable: true)
    attribute :opacity,   Maps::Types::OpacityKind.meta(omittable: true)
  end
end
