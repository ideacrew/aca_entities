# frozen_string_literal: true

module AcaEntities
  module Accounts
    # Namespace grouping OmniAuth 2 identity strategies
    module Oauth
      # If the authenticating service provides some kind of access token or other credentials upon authentication,
      # these are passed through here
      class Credentials < Dry::Struct
        # @!attribute [r] token
        # Supplied by OAuth and OAuth 2.0 providers, the OpenID Connect ID Token
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :id_token, Types::String.meta(omittable: true)

        # @!attribute [r] token
        # Supplied by OAuth and OAuth 2.0 providers, the access token
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :token, Types::String.meta(omittable: true)

        # @!attribute [r] secret
        # Supplied by OAuth providers, the access token secret
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :secret, Types::String.meta(omittable: true)

        # @!attribute [r] refresh_token
        # Supplied by OAuth providers, the refresh token
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :refresh_token, Types::String.meta(omittable: true)

        # @!attribute [r] scope
        # The scope of the access token
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :scope, Types::String.meta(omittable: true)

        # @!attribute [r] expires_in
        # Duration in seconds the access token is valid from the time of issuance
        # @return [Time]
        attribute? :expires_in, Types::Time.meta(omittable: true)
      end
    end
  end
end
