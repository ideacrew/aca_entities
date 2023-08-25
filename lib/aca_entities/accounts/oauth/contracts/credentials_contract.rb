# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      module Contracts
        # Contract for validating a {AcaEntitiess::Accounts::Oauth::Credentials} entity based on
        # Omniauth schema 1.0 and later
        class CredentialsContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Oauth::Credentials}
          # @option opts [String] :token Supplied by OAuth and OAuth 2.0 providers, the access token
          # @option opts [String] :secret The access token secret
          # @option opts [String] :expires Flag indicating whether the access token has an expiry date
          # @option opts [String] :expires_at Timestamp of the expiry time
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          params do
            optional(:token).maybe(:string)
            optional(:secret).maybe(:string)
            optional(:expires).maybe(:bool)
            optional(:expires_at).maybe(:time)
          end
        end
      end
    end
  end
end
