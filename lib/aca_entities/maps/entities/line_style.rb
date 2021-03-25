# frozen_string_literal: true

module AcaEntities
  module Maps
    class LineStyle < Dry::Struct
      attribute :color,     Maps::Types::Css3ColorKind.meta(omittable: true)
      attribute :opacity,   Maps::Types::OpacityKind.meta(omittable: true)
      attribute :weight,    Types::Integer.meta(omittable: true)
    end
  end
end
