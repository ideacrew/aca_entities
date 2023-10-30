# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      # Returns an identity instance representing a party (e.g.: person, organization, service) serialized
      # for exchange with a trusted third-party OAuth2 identity service Provider.
      class Identity < Dry::Struct
        # @!attribute [r] id
        # Local data store's assigned key for this identity instance
        # @return [String]
        attribute? :id, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] provider
        # Identifier for the third party OAuth service that authenticated this account
        # @return [String]
        attribute :provider, Types::String.meta(omittable: false)

        # @!attribute [r] uid
        # A Provider-assigned unique identifier for this identity instance
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
      end
    end
  end
end
