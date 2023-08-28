# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      # Information information about the authentication identity
      class Info < Dry::Struct

        # @!attribute [r] name
        # Display name for the OAuth account. Usually a concatenation of first and last name of the owner
        # but may also be an arbitrary designator or nickname
        # @return [String]
        attribute :name, Types::String.meta(omittable: false)

        # @!attribute [r] description
        # A short description of the authenticating user
        # @return [String]
        attribute :description, Types::String.meta(omittable: true)

        # @!attribute [r] email
        # Email address of the authenticating user
        # @return [String]
        attribute :email, Types::String.meta(omittable: true)

        # @!attribute [r] nickname
        # The username of the authenticating user
        # @return [String]
        attribute :nickname, Types::String.meta(omittable: true)

        # @!attribute [r] first_name
        # The given name of an authenticating user
        # @return [String]
        attribute :first_name, Types::String.meta(omittable: true)

        # @!attribute [r] last_name
        # The sirname of an authenticating user
        # @return [String]
        attribute :last_name, Types::String.meta(omittable: true)

        # @!attribute [r] last_name
        # The general location of the user, usually a city and state.
        # @return [String]
        attribute :location, Types::String.meta(omittable: true)

        # @!attribute [r] image
        # A URL representing a profile image of the authenticating user.
        # Where possible, should be specified to a square, roughly 50x50 pixel image
        # @return [AcaEntities::Types::UriKind]
        attribute :image, AcaEntities::UriKind.meta(omittable: true)

        attribute :phone, Types::String.meta(omittable: true)
        attribute :urls, Types::String.meta(omittable: true)

      end
    end
  end
end
