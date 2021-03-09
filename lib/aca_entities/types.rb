# frozen_string_literal: true

require 'dry-types'

module AcaEntities

  # Extend DryTypes
  module Types
    send(:include, Dry.Types())
    send(:include, Dry::Logic)

    UsStateAbbreviationKind = Types::String.enum('DC', 'MA', 'ME')

    EmployeeStatusCodeKinds = Types::Coercible::String.enum(
      'NoLongerEmployed',
      'Retired',
      'CurrentlyEmployed'
    )

    LcsopCoverageCodeKinds = Types::Coercible::String.enum(
      'Offers',
      'DoesNotOffer',
      'PlansToOffer',
      'PlansToDrop',
      'PlansToChangeOptions',
      'Unknown',
      'PlansToChangeCost'
    )

    LcsopCostCodeKinds = LcsopCoverageCodeKinds
  end
end
