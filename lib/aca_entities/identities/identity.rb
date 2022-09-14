# frozen_string_literal: true

module AcaEntities
  module Identities
    # A Single Sign-on (SSO) identity assigned to a person or service for
    # authenticating and authorizing access to system resources.
    class Identity < Dry::Struct
      # @!attribute [r] id
      # System-assigned unique identifier
      # @return [String]
      attribute? :id, Types::String.meta(omittable: true)

      # @!attribute [r] provider
      # The service with which this identity is authenticated
      # @return [String]
      attribute :provider, Types::String.meta(omittable: false)

      # @!attribute [r] user_id
      # An identifier unique to the given provider. Often, the {email} value is the same as user_id.
      # Either an {email} or {username} value must be present to pass validation
      # @return [String]
      attribute :user_id, Types::String.meta(omittable: false)

      # @!attribute [r] name
      # The display name. Usually a concatenation of first and last name, but may also be an arbitrary
      # designator or nickname
      # @return [String]
      attribute :name, Types::String.meta(omittable: false)

      # @!attribute [r] email
      # The email name of the authenticated identity
      # Either an {email} or {username} value must be present to pass validation
      # @return [String]
      attribute? :email, AcaEntities::Types::EmailAddressKind.meta(omittable: true)

      # @!attribute [r] email_verified
      # Flag indicating whether the email address associated with this Identity has been verified
      # @return [String]
      attribute? :email_verified, Types::Bool.meta(omittable: true)

      # @!attribute [r] enabled
      # Flag indicating whether this Identity is active
      # @return [String]
      attribute? :enabled, Types::Bool.meta(omittable: true)

      # @!attribute [r] first_name
      # Given name of the Identity holder
      # @return [String]
      attribute? :first_name, Types::String.meta(omittable: true)

      # @!attribute [r] last_name
      # Surname name of the Identity holder
      # @return [String]
      attribute? :last_name, Types::String.meta(omittable: true)

      # @!attribute [r] password
      # A secret word or phrase used to authenticate an identiry in combination with
      # an email or username. Password value must meet system complexity policies
      # @return [String]
      attribute? :password, Types::String.meta(omittable: true)
      attribute? :attributes, Types::Hash.meta(omittable: true)
      attribute? :realm_roles, Types::Array.of(Types::String).meta(omittable: true)
      attribute? :client_roles, Types::Array.of(Types::String).meta(omittable: true)
      attribute? :groups, Types::Array.of(Types::String).meta(omittable: true)
      attribute? :access, Types::Hash.meta(omittable: true)
      attribute? :profile, AcaEntities::Identities::Profile.meta(omittable: true)
      attribute? :created_at, Types::DateTime.meta(omittable: true)
    end
  end
end
