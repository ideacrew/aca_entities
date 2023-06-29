# frozen_string_literal: true

module AcaEntities
  module Identities
    module Omniauth
      # Information a Provider service returns to an authenticated client about an identity
      class Info < Dry::Struct
        # @!attribute [r] name
        # The best display name known to the strategy. Usually a concatenation of first and last name,
        # but may also be an arbitrary designator or nickname for some strategies
        # @return [String]
        attribute :name, Types::String.meta(omittable: false)

        # @!attribute [r] name
        # The e-mail of the authenticating user. Should be provided if at all possible
        # @return [String]
        attribute? :email, Types::String.meta(omittable: true)

        # @!attribute [r] nickname
        # The username of an authenticating user
        # @return [String]
        attribute? :nickname, Types::String.meta(omittable: true)

        # @!attribute [r] first_name
        # The given name of an authenticating user
        # @return [String]
        attribute? :first_name, Types::String.meta(omittable: true)

        # @!attribute [r] last_name
        # The surname of an authenticating user
        # @return [String]
        attribute? :last_name, Types::String.meta(omittable: true)

        # @!attribute [r] location
        # The general location of the user, usually a city and state
        # @return [String]
        attribute? :location, Types::String.meta(omittable: true)

        # @!attribute [r] description
        # A short description of the authenticating user
        # @return [String]
        attribute? :description, Types::String.meta(omittable: true)

        # @!attribute [r] image
        # A URL representing a profile image of the authenticating user. Where possible, should be specified to a square,
        # roughly 50x50 pixel image
        # @return [String]
        attribute? :image, Types::String.meta(omittable: true)

        # @!attribute [r] phone
        # The telephone number of the authenticating user
        # @return [String]
        attribute? :phone, Types::String.meta(omittable: true)

        # @!attribute [r] urls
        # A hash containing key value pairs of an identifier for the website and its URL. For instance, an entry could be
        # "Blog" => "http://example.com/blog"
        # @return [Hash]
        attribute? :urls, Types::Hash.meta(omittable: true)
      end
    end
  end
end
