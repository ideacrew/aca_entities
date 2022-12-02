# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        class DataLayer < Dry::Struct
          attribute :features, Types::Array.of(AcaEntities::Locations::GeoJson::Feature).meta(omittable: false)
        end
      end
    end
  end
end
