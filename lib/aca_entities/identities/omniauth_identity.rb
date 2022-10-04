# frozen_string_literal: true

module AcaEntities
  module Identities
    # A security scheme that standardizes authentication across multiple providers
    class OmniauthIdentity < Dry::Struct
      # @!attribute [r] provider
      # The service with which this identity is authenticated
      # @return [String]
      attribute :provider, Types::String.meta(omittable: false)

      # @!attribute [r] user_id
      # An identifier unique to the given provider. Often, the {email} value is the same as user_id.
      # Either an {email} or {username} value must be present to pass validation
      # @return [String]
      attribute :user_id, Types::String.meta(omittable: false)

      # @!attribute [r] password
      # An encrypted secret word or phrase used to authenticate an identity in combination with
      # an email or username. Password value must meet system complexity policies
      # @return [String]
      attribute? :password, Types::String.meta(omittable: true)

      # attribute? :attributes, Types::Hash.meta(omittable: true)
      # attribute? :realm_roles, Types::Array.of(Types::String).meta(omittable: true)
      # attribute? :client_roles, Types::Array.of(Types::String).meta(omittable: true)
      # attribute? :groups, Types::Array.of(Types::String).meta(omittable: true)
      # attribute? :access, Types::Hash.meta(omittable: true)
    end
  end
end
