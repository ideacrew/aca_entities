# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      module Contracts
        # Contract for validating a {AcaEntities::Accounts::Oauth::Identity} entity based on
        # the [Omniauth](https://github.com/omniauth/omniauth) gem's
        # [Auth Hash Schema 1.0]((https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema).
        class IdentityContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntitiess::Identities::Omniauth::Auth}
          # @option opts [String] :provider The service with which this identity authenticated (required)
          # @option opts [String] :uid An identifier for this identity unique to the given provider (required)
          # @option opts [AcaEntities::Accounts::Oauth::Contracts::InfoContract] :info Information about the
          #   identity (required)
          # @option opts [AcaEntities::Accounts::Oauth::Contracts::CredentialsContract] :credentials provider-assigned access
          #   token or other credentials returned upon authentication
          # @option opts [Hash] :extra Extra information returned from the authentication provider
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          json do
            required(:provider).filled(:string)
            required(:uid).filled(:string)
            required(:info).filled(AcaEntities::Accounts::Oauth::Contracts::InfoContract.params)
            optional(:credentials).maybe(AcaEntities::Accounts::Oauth::Contracts::CredentialsContract.params)
            optional(:extra).maybe(AcaEntities::Accounts::Oauth::Contracts::ExtraContract.params)
          end
        end
      end
    end
  end
end
