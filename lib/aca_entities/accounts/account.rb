# frozen_string_literal: true

module AcaEntities
  module Accounts
    # A Single Sign On (SSO) account for a person or service that is authenticated through a
    # trusted third party Provider services
    class Account < Dry::Struct
      # @!attribute [r] id
      # Local service data store's unique identifier for this account
      # @return [String]
      attribute? :id, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] name
      # Local service data store's unique identifier for this account
      # @return [String]
      attribute :name, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] identities
      # A list of authentication Provider identities associated with this account
      # @return [Array<AcaEntities::Accounts::Identity>]
      attribute :identities, Types::Array.of(AcaEntities::Accounts::Identity).meta(omittable: false)

      # @!attribute [r] profile
      # Account holder's enterprise service settings, including preferences and authorization permissions
      # See [Managing Multiple Providers](https://github.com/omniauth/omniauth/wiki/Managing-Multiple-Providers)
      # @return [AcaEntities::Accounts::Profile]
      attribute? :profile, AcaEntities::Accounts::Profile.meta(omittable: true)

      # @!attribute [r] sign_in_count
      # The number of times this account has been authenticated on this service
      # @return [Integer]
      attribute? :sign_in_count, Types::Integer.meta(omittable: true)

      # @!attribute [r] current_sign_in_at
      # The timestamp when the current session for this account started
      # @return [Time]
      attribute :current_sign_in_at, Types::Time.meta(omittable: true)

      # @!attribute [r] last_sign_in_at
      # The timestamp when the most recent session for this account started
      # @return [Time]
      attribute? :last_sign_in_at, Types::Time.meta(omittable: true)

      # @!attribute [r] current_sign_in_ip
      # The IP address for the current session for this account
      # @return [String]
      attribute? :current_sign_in_ip, Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] last_sign_in_ip
      # The IP address for the most recent session for this account started
      # @return [String]
      attribute? :last_sign_in_ip, Types::StringOrNil.meta(omittable: true)

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
