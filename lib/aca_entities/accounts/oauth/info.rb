# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      # Information about the authentication identity
      class Info < Dry::Struct
        # @!attribute [r] nickname
        # Username of the authenticatied identity
        # @return [String]
        attribute :nickname, Types::String.meta(omittable: false)

        # @!attribute [r] name
        # Display name for the OAuth account. Usually a concatenation of first and last name of the owner
        # but may also be an arbitrary designator or nickname
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :name, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] email
        # Email address of the authenticatied identity
        # @return [AcaEntities::Types::EmailOrNil]
        attribute? :email, AcaEntities::Types::EmailOrNil.meta(omittable: true)

        # @!attribute [r] email_verified
        # Whether the email has been verified by the identity provider
        # @return [Boolean]
        attribute? :email_verified, Types::Bool.meta(omittable: true)

        # @!attribute [r] first_name
        # Given name of the authenticatied identity
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :first_name, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] last_name
        # Surname of the authenticatied identity
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :last_name, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] image
        # A URL representing a profile image of the authenticatied identity.
        # Where possible, should be specified to a square, roughly 50x50 pixel image
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :image, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] gender
        # The gender of the authenticatied identity
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :gender, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] phone
        # Telephone number of the authenticatied identity
        # @return [AcaEntities::Types::NumbersOrNil]
        attribute? :phone, AcaEntities::Types::NumbersOrNil.meta(omittable: true)

        # @!attribute [r] urls
        # A hash containing key value pairs of an identifier for the website and its URL
        # @return [Hash]
        attribute? :urls, Types::Hash.meta(omittable: true)

        # @!attribute [r] location
        # The general location of the user, usually a city and state.
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :location, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] description
        # A short description of the authenticatied identity
        # @return [AcaEntities::Types::StringOrNil]
        attribute? :description, AcaEntities::Types::StringOrNil.meta(omittable: true)
      end
    end
  end
end
