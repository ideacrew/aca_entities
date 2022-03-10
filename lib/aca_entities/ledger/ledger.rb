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
    require_relative 'contracts/user_fee_report_item_contract'
    require_relative 'contracts/user_fee_report_contract'
    require_relative 'contracts/insurer_contract'
    require_relative 'contracts/premium_contract'
    require_relative 'contracts/account_contract'
    require_relative 'contracts/product_contract'

    # require_relative 'contracts/user_fee_contract'
    require_relative 'contracts/tax_household_contract'
    require_relative 'contracts/member_contract'
    require_relative 'contracts/enrolled_member_contract'
    require_relative 'contracts/marketplace_segment_contract'
    require_relative 'contracts/policy_contract'
    require_relative 'contracts/insurance_coverage_contract'
    require_relative 'contracts/transaction_header_contract'
    require_relative 'contracts/meta_contract'
    require_relative 'contracts/customer_contract'
    require_relative 'contracts/gdb_transaction_contract'

    # entities
    require_relative 'account'
    require_relative 'insurer'
    require_relative 'product'
    require_relative 'premium'

    # require_relative 'tax_household'
    require_relative 'member'
    require_relative 'enrolled_member'
    require_relative 'marketplace_segment'
    require_relative 'policy'

    # operations
  end
end
