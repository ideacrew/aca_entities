# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    require_relative 'types'

    # require_relative 'contracts/types_contract'
    require_relative 'contracts/evidence_item_contract'
    require_relative 'contracts/evidence_state_contract'
    require_relative 'contracts/eligibility_item_contract'
    require_relative 'contracts/eligibility_contract'
    require_relative 'contracts/determination_contract'
    require_relative 'contracts/subjects_contract'

    # require_relative 'contracts/eligibility_snapshot_contract'

    require_relative 'evidence_item'
    require_relative 'evidence_state'
    require_relative 'eligibility_item'
    require_relative 'determination'
    require_relative 'subject'
    require_relative 'eligibility_snapshot'

    attribute :status, AcaEntities::Eligibilities::Types::DeterminationStateKind.meta(omittable: false)
    attribute :earliest_due_date, Types::Date.meta(omittable: false)
    attribute :determined_at, Types::DateTime.meta(omittable: false)
    attribute :evidence_states, AcaEntities::Eligibilities::EvidenceStates.meta(omittable: false)

    def status
      evidence_states.any?
    end

    def earliest_evidence_due_date
      evidence_states
    end

    def determined_at; end

  end
end
