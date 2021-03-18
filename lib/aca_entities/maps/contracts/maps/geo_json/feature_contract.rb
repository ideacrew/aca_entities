# frozen_string_literal: true

module Maps::GeoJson
  class FeatureContract < ApplicationContract
    params do
      required(:type).filled(Maps::GeoJson::Types::FeatureKind)
      required(:geometry).filled(:hash)
      required(:properties).filled(:hash)
    end
  end
end
