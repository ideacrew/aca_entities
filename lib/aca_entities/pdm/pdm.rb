# frozen_string_literal: true

module AcaEntities
  # Domain model entities, contracts and associated objects related to
  # PDM (periodic data matching) proceses like PVC and RRV
  #
  module Pdm
    # shared dependencies
    # types
    require 'aca_entities/types'

    # external
    # dependencies
    # require 'aca_entities/libraries/core_library'
    require 'aca_entities/timestamp'

    require_relative 'types'

    # shared contracts
    require_relative 'contracts/manifest_contract'

    # shared entities
    require_relative 'entitites/manifest'
  end
end
