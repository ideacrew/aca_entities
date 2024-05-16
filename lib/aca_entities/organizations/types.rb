# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Organizations
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      OrganizationKind = PublicOrganizationKind | PrivateOrganizationKind

      PrivateOrganizationKind =
        Types::Coercible::String.enum(
          'tax_exempt_organization',
          'c_corporation',
          's_corporation',
          'partnership',
          'limited_liability_corporation',
          'limited_liability_partnership',
          'household_employer',
          'embassy'
        ).freeze

      PublicOrganizationKind = Types::Coercible::String.enum('public').freeze
    end
  end
end
