# frozen_string_literal: true

module AcaEntities
  module Identities
    module Keycloak
      module Contracts
        # Contract for validating a {AcaEntities::Identities::Keycloak::UserRepresentation} entity
        class UserRepresentationContract < Contract
          params do
            optional(:access).maybe(:hash)
            optional(:attributes).maybe(:hash)
            optional(:clientConsents).array(:string)
            optional(:clientRoles).maybe(:hash)
            optional(:createdTimestamp).maybe(:integer)
            optional(:credentials).array(
              AcaEntities::Identities::Keycloak::Contracts::CredentialRepresentationContract.params
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
end
