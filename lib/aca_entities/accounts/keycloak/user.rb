# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Keycloak
      # Keycloak API payload represntation of User
      class User < Dry::Struct
        attribute :access, Types::Hash.optional.meta(omittable: true)
        attribute :attributes, Types::Hash.optional.meta(omittable: true)
        attribute :clientConsents,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :clientRoles, Types::Hash.optional.meta(omittable: true)
        attribute :createdTimestamp, Types::Integer.optional.meta(omittable: true)
        attribute :credentials,
                  Types::Array
                    .of(AcaEntities::Accounts::Keycloak::Credentials)
                    .optional
                    .meta(omittable: true)
        attribute :disableableCredentialTypes,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :email, Types::String.optional.meta(omittable: true)
        attribute :emailVerified, Types::Bool.optional.meta(omittable: true)
        attribute :enabled, Types::Bool.optional.meta(omittable: true)
        attribute :federatedIdentities,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :federationLink,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :firstName, Types::String.optional.meta(omittable: true)
        attribute :groups,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :id, Types::String.optional.meta(omittable: true)
        attribute :lastName, Types::String.optional.meta(omittable: true)
        attribute :notBefore, Types::Integer.optional.meta(omittable: true)
        attribute :origin, Types::String.optional.meta(omittable: true)
        attribute :realmRoles,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :requiredActions,
                  Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :self, Types::String.optional.meta(omittable: true)
        attribute :serviceAccountClientId,
                  Types::String.optional.meta(omittable: true)
        attribute :username, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
