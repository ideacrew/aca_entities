# frozen_string_literal: true

module AcaEntities
  module Locations
    module GeoJson
      module Contracts
        # contract for Geojson Feature
        class FeatureContract < Contract
          params do
            required(:type).filled(AcaEntities::Locations::GeoJson::Types::FeatureKind)
            required(:geometry).filled(:hash)
            required(:properties).filled(:hash)
          end
        end
      end
    end
  end
end
