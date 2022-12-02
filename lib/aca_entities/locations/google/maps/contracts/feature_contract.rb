# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        # Schema and validation rules for the {AcaEntities::Locations::Google::Maps::Feature} entity
        class FeatureContract < Contract
          json do
            required(:type).filled(AcaEntities::Locations::GeoJson::Types::FeatureKind)
            required(:geometry).hash do
              required(:type).filled(AcaEntities::Locations::GeoJson::Types::GeometryKind)
              required(:coordinates).filled(:array)
            end
            required(:properties).filled(:hash)
          end
        end
      end
    end
  end
end
