# frozen_string_literal: true

module Maps::GeoJson
  class GeometryContract < ApplicationContract
    params do
      required(:type).filled(Maps::GeoJson::Types::GeometryKind)
      required(:coordinates).filled(:array)
    end
  end
end
