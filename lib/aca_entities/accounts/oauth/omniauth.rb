# frozen_string_literal: true

module AcaEntities
  module Accounts
    # Namespace grouping OmniAuth 2 identity service authentication strategies
    module Oauth
      # dependencies
      require 'aca_entities/contracts/contract'

      # contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/credentials_contract'
      require_relative 'contracts/info_contract'
      require_relative 'contracts/omniauth_contract'

      # entities
      require_relative 'credentials'
      require_relative 'info'

      # An identity model for multi-provider authenticaction.  The model applies the OmniAuth 2 (OAuth) # standard,
      # which defines a common interface for multiple identity provider services and authentication strategies.
      # Community-supported plug-in adapters are available for a variety of
      # [identity provider services](https://github.com/omniauth/omniauth/wiki/List-of-Strategies).
      # The model follows the [Auth Hash Schema 1.0]((https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema).
      # standard.
      class Omniauth < Dry::Struct
        # @!attribute [r] provider
        # The identity service with which the account was authenticated
        # @return [String]
        attribute :provider, Types::String.meta(omittable: false)

        # @!attribute [r] uid
        # Unique identifier assigned by the identity provider service
        # @return [String]
        attribute :uid, Types::String.meta(omittable: false)

        # @!attribute [r] info
        # Information about the authenticated identity
        # @return [AcaEntities::Accounts::Oauth::Info]
        attribute :info, AcaEntities::Accounts::Oauth::Info.meta(omittable: false)

        # @!attribute [r] credentials
        # Access token or other credentials the authenticating service may have provided
        # @return [AcaEntities::Accounts::Oauth::Credentials]
        attribute? :credentials, AcaEntities::Accounts::Oauth::Credentials.meta(omittable: true)

        # @!attribute [r] extra
        # @return [AcaEntities::Accounts::Oauth::Extra]
        attribute? :extra, Types::Hash.meta(omittable: true)

        # @!attribute [r] time_stamp
        # Date and time when this record was created and last updated
        # @return [AcaEntities::TimeStamp]
        attribute? :time_stamp, AcaEntities::TimeStamp.meta(omittable: true)
      end
    end
  end
end
