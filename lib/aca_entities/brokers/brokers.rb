# frozen_string_literal: true

module AcaEntities
  module Brokers
    # depdendencies
    require 'aca_entities/organizations/organizations'
    require 'aca_entities/people/contracts/person_reference_contract'

    # contracts
    require_relative 'contracts/broker_role_reference_contract'
    require_relative 'contracts/broker_account_contract'
    require_relative 'contracts/broker_role_contract'

    # entities
    require_relative 'broker_role_reference'
    require_relative 'broker_account'
    require_relative 'broker_role'
  end
end
