# frozen_string_literal: true

module AcaEntities
  module Maps
    module GeoJson
      # contract for Geojson Feature
      class FeatureContract < Dry::Validation::Contract
        params do
          required(:type).filled(Maps::Types::FeatureKind)
          required(:geometry).filled(:hash)
          required(:properties).filled(:hash)
        end
      end
    end
  end
end
