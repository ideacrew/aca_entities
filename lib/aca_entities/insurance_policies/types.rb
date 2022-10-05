# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module InsurancePolicies
    # Defined custom types for AcaEntities::InsurancePolicies
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      AcaInsuranaceProductKind = Types::Coercible::String.enum('health', 'dental')

      # Example group with ancillary insurance types
      GroupInsuranceProductKind =
        Types::Coercible::String.enum('dental', 'health', 'short_term_diability', 'long_term_disability', 'term life')
      LifeInsuranceProductFeatureKind = Types::Coercible::String.enum('term', 'universal life')
      LifeInsuranceCoverageKind = Types::Coercible::String.enum('death_coverage_type')
      LifeInsuranceCoverageLevelKind = Types::Coercible::String.enum(250_000)
      LifeInsuranceCoverageLevelBasisKind = Types::Coercible::String.enum('pay benificiary at time of loss')

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
          'effective_date_changed',
          'insurance_agent_assigned'
        )

      InsurancePolicyKind = Types::Coercible::String.enum('individual', 'group')

      # ExpectedContribution
      # premium_credit_monthly_cap
    end
  end
end
