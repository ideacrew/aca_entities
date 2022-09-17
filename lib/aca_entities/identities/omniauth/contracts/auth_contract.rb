# frozen_string_literal: true

module AcaEntities
  module Identities
    module Omniauth
      module Contracts
        # Contract for validating a {AcaEntitiess::Identities::Omniauth::Auth} entity.
        # Omniauth schema 1.0 and later
        class AuthContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntitiess::Identities::Omniauth::Auth}
          # @option opts [String] :provider The service with which this identity authenticated (required)
          # @option opts [String] :uid An identifier for this identity unique to the given provider (required)
          # @option opts [AcaEntities::Identity::Omniauth::Contracts::Info] :info Information about the identity (required)
          # @option opts [AcaEntities::Identity::Omniauth::Contracts::Credentials] :credentials provider-assigned access token or other credentials
          #   returned upon authentication
          # @option opts [Hash] :extra Extra information returned from the authentication provider
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          params do
            required(:provider).filled(:string)
            required(:uid).filled(:string)
            required(:info).filled(AcaEntities::Identities::Omniauth::Contracts::InfoContract.params)
            optional(:credentials).maybe(AcaEntities::Identities::Omniauth::Contracts::CredentialsContract.params)
            optional(:extra).hash { optional(:raw_info).maybe(:hash) }
          end
        end
      end
    end
  end
end
