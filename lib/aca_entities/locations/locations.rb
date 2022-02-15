# frozen_string_literal: true

module AcaEntities
  # Domain model entities, contracts and associated
  # resources for addresses and geographic points, lines
  # and boundaries
  module Locations
    # shared dependencies
    # types
    require 'aca_entities/types'

    # external dependencies
    # require 'aca_entities/libraries/core_library'
    # require 'aca_entities/timestamp'

    # shared contracts
    require 'aca_entities/contracts/locations/address_contract'

    # shared entities
    require_relative 'address'

    # require_relative 'entities/address'
    require_relative 'entities/location'
    require_relative 'entities/us_state_name'
    require_relative 'entities/us_state'

    # operations
  end
end
