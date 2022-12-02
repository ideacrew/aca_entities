# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      # Domain model entities, contracts and associated resources for accessing
      # SmartyStreets US Street Address verification services
      module Smarty
        # shared dependencies
        # types
        require 'aca_entities/types'
        require_relative 'types'

        # external dependencies
        # require 'aca_entities/libraries/core_library'
        # require 'aca_entities/timestamp'

        # shared contracts
        require_relative 'contracts/contract'
        require_relative 'contracts/credentials_contract'
        require_relative 'contracts/lookup_contract'
        require_relative 'contracts/response_contract'

        # shared entities
        require_relative 'lookup'

        # operations
        require_relative 'operations/transforms/address_to/smarty_lookup'
        require_relative 'operations/transforms/smarty_response_to/address'
        require_relative 'operations/verify_address'
      end
    end
  end
end
