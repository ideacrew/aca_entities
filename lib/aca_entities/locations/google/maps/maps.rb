# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::Locations} Domain Model.
  # A Location is a geographic place or an area, referenced as an street address,
  # service area, rating area, state boundary, latitude/longitude and other forms.
  module Locations
    module Google
      module Maps
        # Dependencies
        require 'aca_entities/locations/geo_json/geo_json'

        # Custom Types
        require_relative 'types'

        # Contracts
        require_relative 'contracts/contract'
        require_relative 'contracts/config_contract'
        require_relative 'contracts/data_layer_contract'
        require_relative 'contracts/feature_contract'
        require_relative 'contracts/geocode_request_contract'
        require_relative 'contracts/geocode_response_contract'
        require_relative 'contracts/lat_lng_contract'

        # Entities
        require_relative 'lat_lng'
        require_relative 'center'
        require_relative 'data_layer'
        require_relative 'viewport'
        require_relative 'geocode_response'
        require_relative 'restriction'
        require_relative 'styles'
        require_relative 'map'
      end
    end
  end
end
