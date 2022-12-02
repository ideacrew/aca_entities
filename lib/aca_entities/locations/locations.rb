# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::Locations} Domain Model.
  # A Location is a geographic place or an area, referenced as an street address,
  # service area, rating area, state boundary, latitude/longitude and other forms.
  module Locations
    # Dependencies

    # Custom Types
    require_relative 'types'

    # Contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/geographic_coordinates_contract'

    # Entities
    require_relative 'addresses/addresses'
    require_relative 'addresses/smarty/smarty'
    require_relative 'geo_json/geo_json'
    require_relative 'google/maps/maps'

    # Domain Model Entitities
  end
end
