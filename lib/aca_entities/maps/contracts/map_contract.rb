# frozen_string_literal: true

module AcaEntities
  module Maps
    # contract for map
    class MapContract < Dry::Validation::Contract
      json do
        required(:center).hash do
          required(:lat).filled(Maps::Types::LatitudeKind)
          required(:lng).filled(Maps::Types::LongitudeKind)
        end
        required(:zoom).filled(:integer)
        optional(:type).filled(Maps::Types::MapTypeIdKind)
        optional(:pitch).filled(:integer)
        optional(:bearing).filled(:integer)
        optional(:options).filled(:hash)
        optional(:meta).filled(:hash)
      end

      # Add validation for options hash
      # rule(:options) do |key, value|
      # end
    end
  end
end
