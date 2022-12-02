# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::Locations} Domain Model.
  # A Location is a geographic place or an area, referenced as an street address,
  # service area, rating area, state boundary, latitude/longitude and other forms.
  module Locations
    module Geojson
      # Dependencies
      require 'aca_entities/locations/geo_json/geo_json'

      # Custom Types
      require_relative 'types'

      # Contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/geometry_contract'
      require_relative 'contracts/feature_contract'
      require_relative 'contracts/query_contract'

      # Entities
      require_relative 'coordinate'
      require_relative 'geometry'
      require_relative 'feature'
      require_relative 'feature_collection'
    end
  end
end
