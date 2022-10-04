# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

module AcaEntities
  module Identities
    # An account unique to an application
    class User < Dry::Struct
      # @!attribute [r] id
      # Application-assigned unique identifier
      # @return [String]
      attribute? :id, Types::String.meta(omittable: true)

      # @!attribute [r] identity
      # A security scheme that authenticates and authorizes access to system resources.
      # @return [AcaEntities::Identities::Identity]
      attribute :identity, AcaEntities::Identities::Identity.meta(omittable: false)

      # @!attribute [r] email
      # The email name of the authenticated identity
      # Either an {email} or {username} value must be present to pass validation
      # @return [String]
      attribute? :email, AcaEntities::Types::EmailAddressKind.meta(omittable: true)

      # @!attribute [r] email_verified
      # Flag indicating whether the email address associated with this Identity has been verified
      # @return [String]
      attribute? :email_verified, Types::Bool.meta(omittable: true)

      # @!attribute [r] attestations
      # Attestations made by this user regarding proof of identity
      # @return [String]
      attribute? :attestations, Types::Array.of(AcaEntities::Attestations::Attestation).meta(omittable: true)

      # @!attribute [r] last_portal_visited
      # Last URL to which this user was routed
      # @return [String]
      attribute? :last_portal_visited, AcaEntities::Types::UriKind.meta(omittable: true)

      # @!attribute [r] profile
      # User preferences and configuration settings
      # @return [AcaEntities::Identities::Profile]
      attribute? :profile, AcaEntities::Identities::UserProfile.meta(omittable: true)

      # @!attribute [r] timestamp
      # Date and time when this record was created and last updated
      # @return [AcaEntities::TimeStamp]
      attribute? :timestamp, AcaEntities::TimeStamp.meta(omittable: true)

      # delegate :email, to: :identity
      # delegate :email_verified, to: :identity
    end
  end
end
