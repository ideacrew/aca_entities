# frozen_string_literal: true

# Module for defining the baseline contracts, entities, types, transformers, and operations
# for CRM (Customer Relationship Management) within the AcaEntities framework.
#
# @note This module acts as a library aggregator for CRM-related functionalities, ensuring
#   that all necessary components (Types, Contracts, Entities, Transformers, and Operations)
#   are loaded and available for use.
module AcaEntities
  module Crm
    module Libraries
      module CrmLibrary

        # Types
        # Loading shared and CRM-specific types for use in contracts and entities.
        require 'aca_entities/types'
        require 'aca_entities/crm/types'

        # Contracts
        # Loading contract files to validate input/output for CRM entities.
        require 'aca_entities/crm/contracts/contact_contract'
        require 'aca_entities/crm/contracts/account_contract'

        # Entities
        # Loading CRM entity definitions.
        require 'aca_entities/crm/contact'
        require 'aca_entities/crm/account'

        # Transformers
        # Loading transformers to convert external data formats to CRM entity formats.
        require 'aca_entities/crm/transformers/sugar_account_to/account'
        require 'aca_entities/crm/transformers/family_to/account'

        # Operations
        # Loading operations that encapsulate business logic for CRM functionalities.
        require 'aca_entities/crm/operations/create_account'
      end
    end
  end
end
