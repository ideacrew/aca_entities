# frozen_string_literal: true

module AcaEntities
  # Domain model entities, contracts and associated
  # resources for integrating with CMS Federal Data Sharing Hub (FDSH).
  #
  # The FDSH top level namespace includes elements shared across the
  # various services.  The namespace for each service is organized first
  # by the service abbreviation and then CMS-asssigned version.
  module Organizations
    # shared dependencies
    # types
    require 'aca_entities/types'

    # require_relative 'types'

    # external
    # dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/timestamp'

    # shared contracts
    require_relative 'contracts/contract'

    # require_relative 'contracts/organization_contract'
    require_relative 'contracts/tenant_contract'

    # shared entities
    # require_relative 'person/person_name'
    # require_relative 'person/person_birth_date'
    # require_relative 'person/person_ssn_identification'

    # services
    # require_relative 'ridp'
    # require_relative 'ifsv'
    # require_relative 'vlp'
    # require_relative 'ssa'
    # require_relative 'esi'
    # require_relative 'non_esi'
    # require_relative 'rrv'
  end
end
