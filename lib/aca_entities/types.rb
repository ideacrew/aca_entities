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

    EmployeeCoverageCode = Types::Coercible::String.enum(
      'Enrolled',
      'PlanningToEnroll',
      'NotEligible',
      'PlanningToDisenroll',
      'Eligible',
      'EligibleNotEnrolledPlanningToEnroll'
    )

    CoverageEndedReasonCode = Types::Coercible::String.enum(
      'UnpaidPremium',
      'DiscontinuedByIssuer',
      'DiscontinuedByEmployer',
      'ChangedEmployer'
    )

    OtherInsuranceTypeCode = Types::Coercible::String.enum(
      'Employer',
      'Private',
      'Medicaid',
      'Medicare',
      'CHIP',
      'TRICARE',
      'VeteranHealthProgram',
      'PeaceCorps',
      'OPM',
      'Federal',
      'State',
      'UnspecifiedLimitedCoverage',
      'UnspecifiedFullCoverage'
    )
  end
end
