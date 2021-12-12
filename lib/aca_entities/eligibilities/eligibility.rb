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

    # class Family
    #   embeds_many :eligibility_snapshots
    # end

    # class EligibilitySnapshot
    #   attribute :enrollment_period # OE or SEP

    #   attribute :eligibility_items
    #   attribute :subjects
    # end

    # class EligibilitySnapshotHistory
    #   belongs_to :family
    #   has_many :eligibility_snapshots

    #   def self.eligibilities_on(date)
    #     []
    #   end
    # end

    # This is an Operation with corresponding Event
    # module Operations
    #   module Eligibilities
    #     class CreateEligibilitySnapshot
    #       params family, options = { event: event, evidences: [:non_esi] }
    #       def call(params)
    #         values = yield validate(params)
    #         eligibilities = yield(values)

    #         income_eligibilities
    #       end
    #     end
    #   end
    # end
  end
end
