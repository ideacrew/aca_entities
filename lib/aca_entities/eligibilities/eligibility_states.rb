# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A collection of {Eligibility} instances
    class EligibilityStates < Dry::Struct
      attribute :eligibility_states, Types::Hash.meta(omittable: false)
    end
  end
end

