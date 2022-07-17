# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::InsurancePolicies} Domain Model
  module InsurancePolicies
    # TODO: Add the classes for the domain in dependency order
    # Custom Types
    require_relative 'types'

    # Contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/member_contract'

    # Domain Model Entitities
    # require_relative 'member'
  end
end
