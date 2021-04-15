# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      # contract for maps createfeature
      class CreateFeatureContract < Dry::Validation::Contract
        json do
          required(:type).filled(Maps::GeoJson::Types::FeatureKind)
          required(:geometry).hash do
            required(:type).filled(Maps::GeoJson::Types::GeometryKind)
            required(:coordinates).filled(:array)
          end
          required(:properties).filled(:hash)
        end
      end
    end
  end
end