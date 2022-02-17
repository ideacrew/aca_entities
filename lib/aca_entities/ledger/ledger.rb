# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Domain model entities, contracts and associated
    # resources for User Fee and Premium Billing
    require 'aca_entities/types'

    # external dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/contracts/people/person_name_contract'
    require 'aca_entities/timestamp'

    # shared contracts
    require_relative 'types'
    require_relative 'contracts/contract'
    require_relative 'contracts/product_contract'
    require_relative 'contracts/premium_contract'
    require_relative 'contracts/tax_household_contract'
    require_relative 'contracts/issuer_contract'
    require_relative 'contracts/member_contract'
    require_relative 'contracts/policy_contract'
    require_relative 'contracts/account_contract'
    require_relative 'contracts/customer_account_contract'

    # operations
  end
end
