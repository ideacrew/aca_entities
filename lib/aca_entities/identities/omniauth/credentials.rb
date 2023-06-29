# frozen_string_literal: true

module AcaEntities
  module Identities
    module Omniauth
      # If the authenticating service provides some kind of access token or other credentials
      # upon authentication, these are passed through here.
      class Credentials < Dry::Struct
        # @!attribute [r] token
        # The access token supplied by OAuth and OAuth 2.0 providers
        # @return [String]
        attribute :token, Types::String.meta(omittable: false)

        # @!attribute [r] secret
        # The access token secret supplied by OAuth providers
        # @return [String]
        attribute? :secret, Types::String.meta(omittable: true)

        # @!attribute [r] expires
        # Boolean indicating whether the access token has an expiry date
        # @return [Boolean]
        attribute? :expires, Types::Bool.meta(omittable: true)

        # @!attribute [r] expires_at
        # The date at which the access token expires
        # @return [Date]
        attribute? :expires_at, Types::Date.meta(omittable: true)
      end
    end
  end
end
