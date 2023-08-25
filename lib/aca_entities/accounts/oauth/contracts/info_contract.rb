# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      module Contracts
        # Contract for validating a {AcaEntitiess::Accounts::Oauth::Info} entity based on
        # Omniauth schema 1.0 and later
        class InfoContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntities::Idnetities::Omniauth::Info}
          # @option opts [String] :name The display name. Usually a concatenation of first and last name, but may also be an arbitrary (required)
          # @option opts [String] :email The email name of the authenticated identity
          # @option opts [String] :nickname The username of an authenticated identity
          # @option opts [String] :first_name The given name of the authenticated identity
          # @option opts [String] :last_name The surname name of the authenticated identity
          # @option opts [String] :location The general location of the authenticated identity, usually a city and state
          # @option opts [String] :description A short description of the authenticated identity
          # @option opts [String] :image A URL representing a profile image of the authenticated identity. Where possible, should be specified to a
          #   square, roughly 50x50 pixel image.
          # @option opts [String] :phone telephone number of the authenticated identity
          # @option opts [Hash] :urls A hash containing key value pairs of an identifier for the website and its URL. For example, an entry could
          #   be "Blog" => "http://example.com/blog"
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          params do
            required(:name).filled(:string)
            optional(:email).maybe(:string)
            optional(:nickname).maybe(:string)
            optional(:first_name).maybe(:string)
            optional(:last_name).maybe(:string)
            optional(:location).maybe(:string)
            optional(:description).maybe(:string)
            optional(:image).maybe(:string)
            optional(:phone).maybe(:string)
            optional(:urls).maybe(:hash)
          end
        end
      end
    end
  end
end
