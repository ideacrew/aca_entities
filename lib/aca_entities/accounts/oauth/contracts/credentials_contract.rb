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
          # @option opts [AcaEntities::Types::StringOrNil] :id_token The OpenID Connect ID Token
          # @option opts [AcaEntities::Types::StringOrNil] :token Supplied by OAuth and OAuth 2.0 providers, the access token
          # @option opts [AcaEntities::Types::StringOrNil] :secret Supplied by OAuth and OAuth 2.0 providers, the access token secret
          # @option opts [AcaEntities::Types::StringOrNil] :refresh_token Supplied by OAuth and OAuth 2.0 providers, the refresh token
          # @option opts [Integer] :expires_in Duration in seconds the access token is valid from the time of issuance
          # @option opts [AcaEntities::Types::StringOrNil] :scope The scope of the access token
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          json do
            optional(:id_token).maybe(AcaEntities::Types::StringOrNil)
            optional(:token).maybe(AcaEntities::Types::StringOrNil)
            optional(:secret).maybe(AcaEntities::Types::StringOrNil)
            optional(:refresh_token).maybe(AcaEntities::Types::StringOrNil)
            optional(:expires_in).maybe(:integer)
            optional(:scope).maybe(AcaEntities::Types::StringOrNil)
          end
        end
      end
    end
  end
end
