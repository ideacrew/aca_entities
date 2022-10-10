# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::Locations} Domain Model
  module Locations
    # Custom Types
    # require_relative 'types'

    # Contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/address_validation_status_contract'
    require_relative 'contracts/site_address_contract'

    # Domain Model Entitities
    require_relative 'address'
  end
end
