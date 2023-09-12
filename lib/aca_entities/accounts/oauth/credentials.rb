# frozen_string_literal: true

module AcaEntities
  module Accounts
    # Namespace grouping OmniAuth 2 identity strategies
    module Oauth
      # If the authenticating service provides some kind of access token or other credentials upon authentication,
      # these are passed through here
      class Credentials < Dry::Struct
        # @!attribute [r] token
        # Supplied by OAuth and OAuth 2.0 providers, the access token
        # @return [String]
        attribute :token, Types::String.meta(omittable: true)

        # @!attribute [r] secret
        # Supplied by OAuth providers, the access token secret
        # @return [String]
        attribute :secret, Types::String.meta(omittable: true)

        # @!attribute [r] expires
        # Flag indicating whether the access token has an expiry date
        # @return [Boolean]
        attribute :expires, Types::Bool.meta(omittable: true)

        # @!attribute [r] expires_at
        # Timestamp of the expiry time
        # @return [Time]
        attribute :expires_at, Types::Time.meta(omittable: true)
      end
    end
  end
end
