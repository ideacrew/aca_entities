# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity AssociatedPolicy
      class AssociatedPolicy < Dry::Struct
        attribute :QHPPolicyNum, AcaEntities::Types::String.optional.meta(omittable: false)
        attribute :QHPIssuerEIN, AcaEntities::Types::String.optional.meta(omittable: false)
        attribute :SLCSPAdjMonthlyPremiumAmt, AcaEntities::Types::Float.meta(omittable: false)
        attribute :HouseholdAPTCAmt, AcaEntities::Types::Float.meta(omittable: false)
        attribute :TotalHsldMonthlyPremiumAmt, AcaEntities::Types::Float.meta(omittable: false)
      end
    end
  end
end
