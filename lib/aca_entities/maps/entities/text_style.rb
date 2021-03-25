# frozen_string_literal: true

module AcaEntities
  module Maps
    class TextStyle < Dry::Struct

      # The color of the label text. Default color is black
      attribute :color,           Maps::Types::Css3ColorKind.meta(omittable: true)

      # The font family of the label text (equivalent to the CSS font-family property
      attribute :font_family,     Types::String.meta(omittable: true)

      # The font size of the label text (equivalent to the CSS font-size property). Default size is 14px
      attribute :font_size,       Types::String.meta(omittable: true)

      # he font weight of the label text (equivalent to the CSS font-weight property)
      attribute :font_weight,     Types::String.meta(omittable: true)
    end
  end
end
