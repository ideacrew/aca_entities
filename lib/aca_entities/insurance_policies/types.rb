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
          'initial_enrollment',
          'dependent_drop',
          'dependent_add',
          'address_change',
          'tobacco_use_rating_change',
          'termination',
          'cancel',
          'reinstate',
          'change_effective_date'
        )

      InsurancePolicyKind = Types::Coercible::String.enum('individual', 'group')

      # ExpectedContribution
      # premium_credit_monthly_cap
    end
  end
end
