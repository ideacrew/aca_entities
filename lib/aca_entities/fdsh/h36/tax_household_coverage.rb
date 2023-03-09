# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity TaxHouseholdCoverage
      class TaxHouseholdCoverage < Dry::Struct
        attribute :ApplicableCoverageMonthNum, AcaEntities::Types::String.meta(omittable: false)
        attribute :Household, AcaEntities::Fdsh::H36::Household.optional.meta(omittable: true)
        attribute :OtherRelevantAdult, AcaEntities::Fdsh::H36::OtherRelevantAdult.optional.meta(omittable: true)
      end
    end
  end
end
