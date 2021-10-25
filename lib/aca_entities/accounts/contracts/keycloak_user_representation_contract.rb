# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating a Keycloak UserRepresentation payload
      class KeycloakUserRepresentationContract < Dry::Validation::Contract
        params do
          optional(:access).maybe(:hash)
          optional(:attributes).maybe(:hash)
          optional(:clientConsents).array(:string)
          optional(:clientRoles).maybe(:hash)
          optional(:createdTimestamp).maybe(:integer)
          optional(:credentials).array(
            AcaEntities::Accounts::Contracts::KeycloakCredentialRepresentationContract
              .params
          )
          optional(:disableableCredentialTypes).array(:string)
          optional(:email).maybe(:string)
          optional(:emailVerified).maybe(:bool)
          optional(:enabled).maybe(:bool)
          optional(:federatedIdentities).array(:string)
          optional(:federationLink).array(:string)
          optional(:firstName).maybe(:string)
          optional(:groups).array(:string)
          optional(:id).maybe(:string)
          optional(:lastName).maybe(:string)
          optional(:notBefore).maybe(:integer)
          optional(:origin).maybe(:string)
          optional(:realmRoles).array(:string)
          optional(:requiredActions).array(:string)
          optional(:self).maybe(:string)
          optional(:serviceAccountClientId).maybe(:string)
          optional(:username).maybe(:string)
        end
      end
    end
  end
end
