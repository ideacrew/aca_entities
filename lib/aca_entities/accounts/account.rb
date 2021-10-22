# frozen_string_literal: true

module AcaEntities
  module Accounts
    # A Single Sign-on (SSO) identity assigned to a person or service for
    # accessing multiple client services.  In Keycloak this is a Realm-level User
    class Account < Dry::Struct
      attribute :id, Types::String.optional.meta(omittable: true)
      attribute :username, Types::String.meta(omittable: false)
      attribute :email,
                AcaEntities::Types::EmailAddressKind.meta(omittable: true)
      attribute :email_verified, Types::Bool.optional.meta(omittable: true)
      attribute :enabled, Types::Bool.optional.meta(omittable: true)
      attribute :totp, Types::Bool.optional.meta(omittable: true)
      attribute :first_name, Types::String.optional.meta(omittable: true)
      attribute :last_name, Types::String.optional.meta(omittable: true)
      attribute :password, Types::String.optional.meta(omittable: true)
      attribute :attributes, Types::Hash.optional.meta(omittable: true)
      attribute :roles,
                Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :groups,
                Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :access, Types::Hash.optional.meta(omittable: true)
      attribute :not_before, Types::Integer.optional.meta(omittable: true)
      attribute :created_at, Types::DateTime.meta(omittable: true)
    end
  end
end
