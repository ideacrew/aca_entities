# frozen_string_literal: true

module AcaEntities
  module Accounts
    # An OmniAuth 2 identity stored on a local service that represents a party (person or service) authenticated
    # through a # trusted third party service
    class Account < Dry::Struct
      # @!attribute [r] id
      # Local database ID for this account
      # @return [String]
      attribute? :id, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] provider
      # The name of the third party service that authenticated this account
      # @return [String]
      attribute :provider, Types::String.meta(omittable: false)

      # @!attribute [r] uid
      # A provider-assigned unique identifier for this account
      # @return [String]
      attribute :uid, Types::String.meta(omittable: false)

      # @!attribute [r] name
      # Display name for the OAuth account. Usually a concatenation of first and last name of the owner
      # but may also be an arbitrary designator or nickname
      # @return [String]
      attribute :name, Types::String.meta(omittable: false)

      # @!attribute [r] email
      # Email address of the authenticated user
      # @return [String]
      attribute? :email, AcaEntities::Types::EmailOrNil.meta(omittable: true)

      # @!attribute [r] encrypted_password
      # Encrypted password for the authenticated user
      # @return [String]
      attribute? :encrypted_password, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] created_at
      # Date and time when this account record was created
      # @return [Time]
      attribute? :created_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)

      # @!attribute [r] updated_at
      # Date and time when this account record was last updated
      # @return [Time]
      attribute? :updated_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)
    end
  end
end
