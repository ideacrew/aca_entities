# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      # Information about the authentication identity
      class Info < Dry::Struct
        # @!attribute [r] name
        # Display name for the OAuth account. Usually a concatenation of first and last name of the owner
        # but may also be an arbitrary designator or nickname
        # @return [String]
        attribute :name, Types::String.meta(omittable: false)

        # @!attribute [r] description
        # A short description of the authenticating user
        # @return [String]
        attribute? :description, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] email
        # Email address of the authenticating user
        # @return [String]
        attribute? :email, AcaEntities::Types::EmailOrNil.meta(omittable: true)

        # @!attribute [r] nickname
        # Username of the authenticating user
        # @return [String]
        attribute? :nickname, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] first_name
        # Given name of the authenticating user
        # @return [String]
        attribute? :first_name, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] last_name
        # Surname of the authenticating user
        # @return [String]
        attribute? :last_name, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] location
        # The general location of the user, usually a city and state.
        # @return [String]
        attribute? :location, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] image
        # A URL representing a profile image of the authenticating user.
        # Where possible, should be specified to a square, roughly 50x50 pixel image
        # @return [String]
        attribute? :image, AcaEntities::Types::StringOrNil.meta(omittable: true)

        # @!attribute [r] phone
        # Telephone number of the authenticating user
        # @return [String]
        attribute? :phone, AcaEntities::Types::NumbersOrNil.meta(omittable: true)

        # @!attribute [r] urls
        # A hash containing key value pairs of an identifier for the website and its URL
        # @return [Hash]
        attribute? :urls, Types::Hash.meta(omittable: true)
      end
    end
  end
end
