# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      module Contracts
        # Contract for validating a {AcaEntitiess::Accounts::Keycloak::OpenidConnect::Extra} entity based on
        # Keycloak's Openid Connect protocol implementation
        class ExtraContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntities::Idnetities::Omniauth::Info}
          # @option opts [AcaEntities::Accounts::OpenidConnect::Contracts::IdTokenContract] :raw_info Devise OpenidConnect returns Keycloak's
          #   OpenId Connect protocol's IdToken key/value pairs here
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation

          json do
            # optional(:raw_info).maybe(AcaEntities::Accounts::OpenidConnect::Contracts::IdTokenContract.params)
            optional(:raw_info).maybe(:hash)
          end
        end
      end
    end
  end
end
