# frozen_string_literal: true

module Maps
  class MapContract < ApplicationContract
    json do
      required(:center).hash do
        required(:lat).filled(Google::Maps::Types::LatitudeKind)
        required(:lng).filled(Google::Maps::Types::LongitudeKind)
      end
      required(:zoom).filled(:integer)
      optional(:type).filled(Google::Maps::Types::MapTypeIdKind)
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
