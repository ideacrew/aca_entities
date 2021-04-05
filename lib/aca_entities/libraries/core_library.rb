# frozen_string_literal: true

# Include the baseline entities and types
module AcaEntities
  module Libraries
    module CoreLibrary
      require 'aca_entities/types'
      require 'aca_entities/contracts/contract'
      require 'aca_entities/contracts/address_contract'
      require 'aca_entities/contracts/email_contract'
      require 'aca_entities/contracts/phone_contract'

      require 'aca_entities/address'
      require 'aca_entities/email'
      require 'aca_entities/phone'

      require 'aca_entities/operations/yaml/deserialize'
    end
  end
end
