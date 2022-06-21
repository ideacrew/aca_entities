# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Domain model entities, contracts and associated
    # resources for BenefitEnrollments
    require 'aca_entities/types'
    require 'aca_entities/contracts/contract'
    require_relative 'types'

    # external dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/contracts/people/person_name_contract'
    require 'aca_entities/timestamp'

    # shared contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/group_premium_credit_contract'
    require_relative 'contracts/member_premium_credit_contract'

    # entities
    require_relative 'group_premium_credit'
    require_relative 'member_premium_credit'

    # operations
  end
end
