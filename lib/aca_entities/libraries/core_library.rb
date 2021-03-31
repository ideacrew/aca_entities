# Include the baseline entities and types

module AcaEntities
  module Libraries
    module CoreLibrary
      require 'aca_entities/types.rb'
      require 'aca_entities/contracts/contract'

      require 'aca_entities/address.rb'
      require 'aca_entities/email.rb'
      require 'aca_entities/phone.rb'

      require 'aca_entities/contracts/address_contract'
      require 'aca_entities/contracts/email_contract'
      require 'aca_entities/contracts/phone_contract'
    end
  end
end
