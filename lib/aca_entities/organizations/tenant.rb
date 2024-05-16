# frozen_string_literal: true

module AcaEntities
  module Organizations
    class Tenant < Dry::Struct
      # @!attribute [r] key
      # Unique ID for tenant host (required)
      # @return [Symbol]
      attribute :key, Types::RequiredSymbol

      # @!attribute [r] organization_name
      # Title for this tenant's organization (required)
      # @return [String]
      attribute :organization_name, Types::String.optional.meta(omittable: false)

      # @!attribute [r] owner_account
      # Reference to Admin account for this tenant (required)
      # @return [String]
      attribute :owner_account, Types::String.optional.meta(omittable: false)
      attribute :subscriptions, Types::Array.of(ResourceRegistry::Entities::Subscription).meta(omittable: true)
      attribute :portals, Types::Array.of(ResourceRegistry::Entities::Portal).meta(omittable: true)
      attribute :settings, Types::Array.of(ResourceRegistry::Entities::Setting).meta(omittable: true)
    end
  end
end
