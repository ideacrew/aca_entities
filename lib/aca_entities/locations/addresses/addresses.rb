# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::Locations} Domain Model
  module Locations
    module Addressses
      # External dependencies

      # Custom Types
      require_relative 'types'

      # Contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/validation_status_contract'
      require_relative 'contracts/address_contract'
      require_relative 'contracts/street_address_contract'

      # Domain Model Entitities
      require_relative 'validation_status'
      require_relative 'address'
      require_relative 'street_address'
    end
  end
end
