# frozen_string_literal: true

require 'dry-types'

module AcaEntities

  # Extend DryTypes
  module Types
    send(:include, Dry.Types())
    send(:include, Dry::Logic)

    UsStateAbbreviationKind = Types::String.enum('DC', 'MA', 'ME')

    EMPLOYEE_STATUS_CODE_KINDS = Types::Coercible::String.enum(
      'NoLongerEmployed',
      'Retired',
      'CurrentlyEmployed'
    )

    LCSOP_COVERAGE_CODE_KINDS = Types::Coercible::String.enum(
      'Offers',
      'DoesNotOffer',
      'PlansToOffer',
      'PlansToDrop',
      'PlansToChangeOptions',
      'Unknown',
      'PlansToChangeCost'
    )

    LCSOP_COST_CODE_KINDS = LCSOP_COVERAGE_CODE_KINDS
  end
end
