# frozen_string_literal: true

# types
require 'aca_entities/types'

# contracts
require_relative 'ssa/h3/contracts/person_contract'
require_relative 'ssa/h3/contracts/ssa_composite_individual_request_contract'
require_relative 'ssa/h3/contracts/ssa_composite_request_contract'

# entities
require_relative 'ssa/h3/person'
require_relative 'ssa/h3/ssa_composite_individual_request'
require_relative 'ssa/h3/ssa_composite_request'

# operations
# require_relative 'vlp/h92/operations/person_to_initial_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/ssa'

