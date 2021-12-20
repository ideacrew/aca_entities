# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A stateful instance of a defined eligibility with one or more
    #   {AcaEntities::Eligiblities::EvidenceState}s
    class Determination < Dry::Struct
      attribute :subjects, Types::Hash.meta(ommittable: false)
    end
  end
end
