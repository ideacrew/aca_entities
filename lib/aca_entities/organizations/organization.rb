# frozen_string_literal: true

module AcaEntities
  module Organizations
    # Information about an Organization
    class Organization < Dry::Struct
      # @!attribute [r] key
      # Human-assigned, short unique ID for this organization.  Typically an
      # abbreviation or acronym of the enterprise.  Must be alphnumeric
      # with no special characters (required)
      # @return [Symbol]
      attribute :key, Types::Symbol.meta(omittable: false)

      # @!attribute [r] title
      # Name for this organization (required). Will appear as branding on
      # Websites
      # @return [String]
      attribute :title, Types::String.optional.meta(omittable: false)

      # @!attribute [r] owner_account
      # Reference to Admin account for this tenant (required)
      # @return [String]
      attribute :owner_account, Types::String.optional.meta(omittable: false)

      # @!attribute [r] subscriptions
      # List of products enabled for this organization
      # @return [Array<String>]
      attribute :subscriptions,
                Types::Array
                  .of(AcaEntities::Enterprises::Subscription)
                  .optional
                  .meta(omittable: true)

      # @!attribute [r] agencies
      # Named sub-divisions or departments that are part of this organization
      # (optional)
      # @return [Array<String>]
      attribute :agencies,
                Array
                  .of(AcaEntities::Organizations::Organization)
                  .optional
                  .meta(omittable: true)

      # @!attribute [r] tenants
      # Third-party entities this Organization supports (optional).  For
      # departments or other subdivisions that are part of this Organization
      # @see {{agencies}}
      # @return [Array<AcaEntities::Enterprises::Tenant>]
      attribute :tenants,
                Types::Array
                  .of(AcaEntities::Enterprises::Tenant)
                  .meta(omittable: true)

      attribute :portals,
                Types::Array
                  .of(AcaEntities::Enterprises::Portal)
                  .meta(omittable: true)

      attribute :settings,
                Types::Array
                  .of(AcaEntities::Enterprises::Setting)
                  .meta(omittable: true)
    end
  end
end
