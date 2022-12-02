# frozen_string_literal: true

module AcaEntities
  module Locations
    module GeoJson
      module Contracts
        # contract for Geojson Geometry
        class GeometryContract < Contract
          params do
            required(:type).filled(AcaEntities::Locations::GeoJson::Types::GeometryKind)
            required(:coordinates).filled(:array)
          end
        end
      end
    end
  end
end
