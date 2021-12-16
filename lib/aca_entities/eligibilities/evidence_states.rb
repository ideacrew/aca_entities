# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A collection of {Subject} instances that possess
    #   eligibility {Determinations}
    class EvidenceStates < Dry::Struct
      attribute :evidence_states, Types::Hash.meta(omittable: false)
    end
  end
end
