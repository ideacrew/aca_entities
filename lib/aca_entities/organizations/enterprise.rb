# frozen_string_literal: true

module AcaEntities
  module Enterprises
    # Top-level namespace for a single domain.  A domain includes tenant
    # organizations along with their respective sites, environments, features
    # and settings
    class Enterprise < Dry::Struct
      # @!attribute [r] owner_account
      # Reference to Super Admin account for this domain (required)
      # @return [String]
      attribute :owner_account,
                AcaEntities::Accounts::Account.meta(omittable: false)

      # @!attribute [r] organization_name
      # Title for organization adminstering this domain (optional)
      # @return [String]
      attribute :organization_name, Types::String.optional.meta(omittable: true)

      # @!attribute [r] options
      # Enterprise-level settings (optional)
      # @return [Array<AcaEntities::Enterprises::Option>]
      attribute :meta,
                Types::Array
                  .of(AcaEntities::Enterprises::Meta)
                  .meta(omittable: true)
    end
  end
end
