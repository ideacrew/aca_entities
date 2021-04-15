# frozen_string_literal: true

module AcaEntities
  module Maps
    module GeoJson
      # contract for Geojson Geometry
      class GeometryContract < Dry::Validation::Contract
        params do
          required(:type).filled(Maps::Types::GeometryKind)
          required(:coordinates).filled(:array)
        end
      end
    end
  end
end
