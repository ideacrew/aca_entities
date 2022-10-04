# frozen_string_literal: true

module AcaEntities
  module People
    # external dependencies
    require 'aca_entities/contracts/verifications/verification_type_contract'
    require 'aca_entities/contracts/verifications/verification_type_history_element_contract'
    require 'aca_entities/brokers/brokers'

    # contracts
    require_relative 'contracts/person_reference_contract'
    require_relative 'contracts/person_relationship_contract'
    require_relative 'contracts/person_name_contract'
    require_relative 'contracts/person_demographics_contract'
    require_relative 'contracts/person_health_contract'
    require_relative 'contracts/resident_role_reference_contract'
    require_relative 'contracts/resident_role_contract'
    require_relative 'contracts/consumer_role_reference_contract'
    require_relative 'contracts/consumer_role_contract'
    require_relative 'contracts/person_contract'

    # entities
    require_relative 'person_reference'
    require_relative 'person_relationship'
    require_relative 'person_name'
    require_relative 'person_demographics'
    require_relative 'person_health'
    require_relative 'resident_role_reference'
    require_relative 'resident_role'
    require_relative 'consumer_role_reference'
    require_relative 'consumer_role'
    require_relative 'person'
  end
end
