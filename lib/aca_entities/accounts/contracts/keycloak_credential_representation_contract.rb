# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating a Keycloak CredentialRepresentation payload in the
      # {AcaEntities::Accounts::Contracts::KeycloakUserRepresentationContract}
      class KeycloakCredentialRepresentationContract < Dry::Validation::Contract
        params do
          optional(:algorithm).maybe(:string)
          optional(:config).maybe(:hash)
          optional(:counter).maybe(:integer)
          optional(:createdDate).maybe(:integer)
          optional(:device).maybe(:string)
          optional(:digits).maybe(:integer)
          optional(:hashIterations).maybe(:integer)
          optional(:hashedSaltedValue).maybe(:string)
          optional(:period).maybe(:integer)
          optional(:salt).maybe(:string)
          optional(:temporary).maybe(:bool)
          optional(:type).maybe(:string)
          optional(:value).maybe(:string)
        end
      end
    end
  end
end
