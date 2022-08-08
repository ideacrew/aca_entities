# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A stateful instance of a defined eligibility with one or more
    #   {AcaEntities::Eligiblities::EligibilityStates}
    class Eligibility < Dry::Struct

      # @!attribute [r] fein
      # Eligibility effective date
      # @return [Date]
      attribute :effective_date, Types::Date

      # @!attribute [r] fein
      # Subject entities for the eligibility
      # @return [Date]
      attribute :subjects, Types::Hash.meta(ommittable: false)
    end
  end
end
