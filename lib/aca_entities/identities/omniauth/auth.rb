# frozen_string_literal: true

module AcaEntities
  module Identities
    module Omniauth
      # Information a Provider service returns to an authenticated client about an identity
      class Auth < Dry::Struct
        # @!attribute [r] provider
        # The service with which this identity is authenticated
        # @return [String]
        attribute :provider, Types::String.meta(omittable: false)

        # @!attribute [r] uid
        # A Provider's unique reference or identifier for the given Identity. Often, the {email} value is
        # the same as uid.
        # @return [String]
        attribute :uid, Types::String.meta(omittable: false)

        # @!attribute [r] info
        # A hash of information about the identity, as returned by the provider
        # @return [Hash]
        attribute :info, AcaEntities::Identities::Omniauth::Auth.meta(omittable: false)

        # @!attribute [r] credentials
        # If the authenticating service provides some kind of access token or other credentials upon authentication, these are passed through here.
        # @return [Hash]
        attribute :credentials, AcaEntities::Identities::Omniauth::Credentials.meta(omittable: false)

        # @!attribute [r] extra
        # Contains extra information returned from the authentication provider. May be in provider-specific formats.
        # @return [Hash]
        attribute? :extra do
          # @!attribute [r] raw_info
          # A hash of all information gathered about a user in the format it was gathered. For example, for Twitter users this is a hash representing
          # the JSON hash returned from the Twitter API.
          # @return [Hash]
          attribute? :raw_info, Types::Hash.meta(omittable: true)
        end
      end
    end
  end
end
