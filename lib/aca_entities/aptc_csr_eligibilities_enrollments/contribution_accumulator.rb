# frozen_string_literal: true

module AcaEntities
  module AptcCsrEligibilitiesEnrollments
    class ContributionAccumulator < Dry::Struct
      attribute :maximum_amount, AcaEntities::Types::Money.meta(omittable: false)
      attribute :balance, AcaEntities::Types::Money.meta(omittable: false)
      attribute :accumulator_adjustments, Types::Array.of(AccumulatorAdjustment).optional.meta(omittable: true)
    end
  end
end