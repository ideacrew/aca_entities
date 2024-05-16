# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Oauth
      module Contracts
        # Contract for validating a {AcaEntitiess::Accounts::Keycloak::OpenidConnect::Info} entity based on
        # OpenidConnect protocol
        class InfoContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntities::Idnetities::Omniauth::Info}
          # @option opts [String] :nickname The username of the authenticated identity (required)
          # @option opts [AcaEntities::Types::StringOrNil] :name The display name. Usually a concatenation of first and last name, but may also be an arbitrary
          # @option opts [AcaEntities::Types::EmailOrNil] :email The email name of the authenticated identity
          # @option opts [Boolean] :email_verified Whether the email has been verified by the identity provider
          # @option opts [AcaEntities::Types::StringOrNil] :first_name The given name of the authenticated identity
          # @option opts [AcaEntities::Types::StringOrNil] :last_name The surname name of the authenticated identity
          # @option opts [AcaEntities::Types::StringOrNil] :gender The gender of the authenticated identity
          # @option opts [AcaEntities::Types::StringOrNil] :image A URL representing a profile image of the authenticated identity. Where possible, should be specified to a
          #   square, roughly 50x50 pixel image.
          # @option opts [AcaEntities::Types::NumbersOrNil] :phone telephone number of the authenticated identity
          # @option opts [Hash] :urls A hash containing key value pairs of an identifier for the website and its URL. For example, an entry could
          #   be "Blog" => "http://example.com/blog"
          # @option opts [AcaEntities::Types::StringOrNil] :location The general location of the authenticated identity, usually a city and state
          # @option opts [AcaEntities::Types::StringOrNil] :description A short description of the authenticated identity
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          json do
            required(:nickname).filled(:string)
            optional(:name).maybe(AcaEntities::Types::StringOrNil)
            optional(:email).maybe(AcaEntities::Types::EmailOrNil)
            optional(:email_verified).maybe(:bool)
            optional(:first_name).maybe(AcaEntities::Types::StringOrNil)
            optional(:last_name).maybe(AcaEntities::Types::StringOrNil)
            optional(:gender).maybe(AcaEntities::Types::StringOrNil)
            optional(:image).maybe(AcaEntities::Types::StringOrNil)
            optional(:phone).maybe(AcaEntities::Types::NumbersOrNil)
            optional(:urls).maybe do
              hash do
                optional(:website).maybe(AcaEntities::Types::StringOrNil)
                optional(:blog).maybe(AcaEntities::Types::StringOrNil)
              end
            end
            optional(:location).maybe(:string)
            optional(:description).maybe(:string)
          end
        end
      end
    end
  end
end
