# frozen_string_literal: true

module AcaEntities
  module Enterprises
    class Tenant < Dry::Struct
      # @!attribute [r] key
      # Short, unique abbreviation for this Tenant (required)
      # Used as a unique reference and subdomain identifier for this Tenant
      # @return [Symbol]
      attribute :key, Types::Symbol.meta(omittable: false)

      # @!attribute [r] owner_accounts (required)
      # Reference to {AcaEntities::Accounts::Account} that controls this Tenant (required)
      # An owner_account may add and remove {Tenant}s and allocate their respective resources
      # @return [Array<Account>]
      attribute :owner_accounts,
                Types::Array
                  .of(AcaEntities::Accounts::Account)
                  .meta(omittable: false)

      # @!attribute [r] organization_name
      # Title for this tenant's organization (required)
      # @return [String]
      attribute :organization_name,
                Types::String.optional.meta(omittable: false)

      # @!attribute [r] owner_organization
      # Information about the organization or group that sponsors this Federation
      # @return [Organization]
      attribute :owner_organization,
                AcaEntities::Enterprises::Organization.optional.meta(
                  omittable: true
                )

      # @!attribute [r] owner_account
      # Reference to Admin account for this tenant (required)
      # @return [String]
      attribute :owner_account, Types::String.optional.meta(omittable: false)

      attribute :subscriptions,
                Types::Array
                  .of(AcaEntities::Enterprises::Subscription)
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
