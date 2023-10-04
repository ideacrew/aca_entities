# frozen_string_literal: true

module AcaEntities
  module Accounts
    # An OmniAuth2 identity stored on a local service that represents a party (person or service) authenticated
    # through a trusted third party service
    class Account < Dry::Struct
      # @!attribute [r] id
      # Local data store's unique identifier for this account
      # @return [String]
      attribute? :id, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] provider
      # An identifier for the third party OAuth service that authenticated this account
      # @return [String]
      attribute :provider, Types::String.meta(omittable: false)

      # @!attribute [r] uid
      # A {Provider}-assigned unique identifier for this account
      # @return [String]
      attribute :uid, Types::String.meta(omittable: false)

      # @!attribute [r] name
      # Display name for the OAuth account. Usually a concatenation of first and last name of the account holder
      # but may also be an arbitrary designator or nickname
      # @return [String]
      attribute :name, Types::String.meta(omittable: false)

      # @!attribute [r] profile
      # Individual person or system account holder's preference settings
      # @return [AcaEntities::Accounts::Profile]
      attribute? :profile, AcaEntities::Accounts::Profile.meta(omittable: true)

      # @!attribute [r] email
      # Email address of the authenticated user
      # @return [AcaEntities::Types::EmailOrNil]
      attribute? :email, AcaEntities::Types::EmailOrNil.meta(omittable: true)

      # @!attribute [r] encrypted_password
      # Encrypted password for the authenticated user
      # @return [AcaEntities::Types::StringOrNil]
      attribute? :encrypted_password, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] created_at
      # The timestamp when this record was originally created in the data store
      # @return [AcaEntities::Types::TimeOrNil]
      attribute? :created_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)

      # @!attribute [r] updated_at
      # The timestamp when this record was last changed in the data store
      # @return [AcaEntities::Types::TimeOrNil]
      attribute? :updated_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)
    end
  end
end
