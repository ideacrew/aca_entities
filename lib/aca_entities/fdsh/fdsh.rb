# frozen_string_literal: true

module AcaEntities
  module Fdsh
    # shared dependencies
    # types
    require 'aca_entities/types'

    # external
    # dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/timestamp'

    # shared contracts
    require_relative 'types'
    require_relative 'contracts/contract'
    require_relative 'contracts/person/person_name_contract'
    require_relative 'contracts/person/person_ssn_identification_contract'
    require_relative 'contracts/person/person_birth_date_contract'

    # shared entities
    require_relative 'person/person_name'
    require_relative 'person/person_birth_date'
    require_relative 'person/person_ssn_identification'

    # services
    require_relative 'ridp'
    require_relative 'ifsv'
    require_relative 'vlp'
    require_relative 'ssa'
  end
end
