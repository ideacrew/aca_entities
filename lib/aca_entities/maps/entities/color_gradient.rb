# frozen_string_literal: true

module AcaEntities
  module Maps
    class ColorGradient < Dry::Struct
      attribute :colors,  Types::Array.of(Maps::Types::Css3ColorKind)
    end
  end
end
