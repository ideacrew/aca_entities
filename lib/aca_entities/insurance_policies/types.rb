# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module InsurancePolicies
    # Defined custom types for AcaEntities::InsurancePolicies
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      CoverageKind = Types::Coercible::String.enum('health', 'dental')

      EnrollmentEventKind =
        Types::Coercible::String.enum(
          'enrolled',
          'enrollment_renewed',
          'dependent_dropped',
          'dependent_added',
          'address_changed',
          'tobacco_use_rating_changed',
          'terminated',
          'canceled',
          'reinstated',
          'effective_date_changed'
        )

      InsurancePolicyKind = Types::Coercible::String.enum('individual', 'group')

      # ExpectedContribution
      # premium_credit_monthly_cap
    end
  end
end
