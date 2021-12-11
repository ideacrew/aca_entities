# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    require_relative 'types'

    # require_relative 'contracts/types_contract'
    require_relative 'contracts/evidence_item_contract'
    require_relative 'contracts/evidence_state_contract'
    require_relative 'contracts/eligibility_item_contract'

    # require_relative 'contracts/eligibility_snapshot_contract'
    require_relative 'contracts/determination_contract'

    require_relative 'evidence_item'
    require_relative 'evidence_state'
    require_relative 'eligibility_item'
    require_relative 'eligibility_snapshot'
    require_relative 'determination'

  end
end
