# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    module Osse
      # A stateful instance of a defined eligibility with one or more
      #   {AcaEntities::Eligiblities::EligibilityStates}
      class Eligibility < Dry::Struct

        # @!attribute [r] subject
        # Subject for the eligibility
        # @return [Dry::Struct]
        attribute :subject, AcaEntities::Eligibilities::Osse::Subject.meta(omittable: false)

        attribute :status?, Types::String.optional.meta(omittable: true)

        attribute :evidences?, Types::Array.of(AcaEntities::Eligibilities::Evidence).meta(omittable: true)

        attribute :grants, Types::Array.of(AcaEntities::Eligibilities::Osse::Grant).meta(omittable: true)

        # @!attribute [r] start_on
        # Eligibility start date
        # @return [Date]
        attribute :start_on, Types::Date

        # @!attribute [r] end_on
        # Eligibility end date
        # @return [Date]
        attribute :end_on, Types::Date.optional.meta(omittable: true)
      end
    end
  end
end