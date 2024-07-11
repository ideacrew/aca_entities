# frozen_string_literal: true

# Include the baseline contracts, entities and types of CRM(Customer Relationship Management)
module AcaEntities
  module Crm
    module Libraries
      module CrmLibrary

        # Types
        require 'aca_entities/types'
        require 'aca_entities/crm/types'

        # Contracts
        require 'aca_entities/crm/contracts/contact_contract'
        require 'aca_entities/crm/contracts/account_contract'

        # Entities
        require 'aca_entities/crm/contact'
        require 'aca_entities/crm/account'

        # Transformers

        # Operations
        require 'aca_entities/crm/operations/create_account'
      end
    end
  end
end
