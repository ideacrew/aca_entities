# frozen_string_literal: true

module AcaEntities
  module Maps
    class StyleSet < Dry::Struct
      attribute :key,       Types::Symbol.meta(omittable: false)
      attribute :styles,    Types::Array.of(Maps::Types::StyleKind).meta(omittable: false)

      attribute :min_zoom,  Types::Integer.meta(omittable: true)
      attribute :visible,   Types::Bool.default(true).meta(omittable: false)

      # attribute :label,     Types::String.meta(omittable: false)
    end
  end
end
