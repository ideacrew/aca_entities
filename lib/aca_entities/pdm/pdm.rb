# frozen_string_literal: true

module AcaEntities
  # Domain model entities, contracts and associated objects related to
  # PDM (periodic data matching) proceses like PVC and RRV
  #
  module Pdm
    # external dependencies
    require 'aca_entities/timestamp'

    require_relative 'types'

    # shared contracts
    require_relative 'contracts/manifest_contract'
    require_relative 'contracts/request_contract'
  end
end
