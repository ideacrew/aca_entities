# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Domain model entities, contracts and associated
    # resources for User Fee and Premium Billing
    require 'aca_entities/types'
    require_relative 'types'
    require_relative 'user_fee_report'
    require_relative 'user_fee_report_item'

    # external dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/contracts/people/person_name_contract'
    require 'aca_entities/timestamp'

    # shared contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/product_contract'
    require_relative 'contracts/premium_contract'
    require_relative 'contracts/tax_household_contract'
    require_relative 'contracts/insurer_contract'
    require_relative 'contracts/member_contract'
    require_relative 'contracts/enrolled_member_contract'
    require_relative 'contracts/marketplace_segment_contract'
    require_relative 'contracts/policy_contract'
    require_relative 'contracts/account_contract'
    require_relative 'contracts/customer_account_contract'
    require_relative 'contracts/user_fee_report_item_contract'
    require_relative 'contracts/user_fee_report_contract'

    # operations
  end
end
