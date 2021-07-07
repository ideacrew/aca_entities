# frozen_string_literal: true

module AcaEntities
  module Fdsh
    # shared dependencies
    require 'aca_entities/types'

    # shared contracts
    require_relative 'types'
    require_relative 'contracts/contract'
    require_relative 'contracts/person/person_name_contract'
    require_relative 'contracts/person/person_ssn_identification_contract'

    # shared entities
    require_relative 'person/person_name'
    require_relative 'person/person_ssn_identification'
  end
end
