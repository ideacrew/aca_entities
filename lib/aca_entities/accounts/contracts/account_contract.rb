# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating a Single Sign-on (SSO) identity assigned to a person
      # or service for use across multiple client services.  In Keycloak this is a Realm-level User
      class AccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Account}
        # @option opts [String] :id A system-defined unique identifier
        # @option opts [String] :username A user-defined unique identifier
        # @option opts [Boolean] :enabled Flag indicating whether the account is active
        # @option opts [String] :email An email addresss associated with the account
        # @option opts [String] :email_verified An email addresss associated with the account
        # @option opts [String] :first_name The account user's first name
        # @option opts [String] :last_name The account user's last name or system service name
        # @option opts [String] :password Credentials that meet system complexity policies
        # @option opts [String] :attributes
        # @option opts [String] :roles
        # @option opts [String] :groups
        # @option opts [Hash] :access
        # @option opts [Integer] :not_before
        # @option opts [DateTime] :created_at Timestamp when this account was created
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          required(:username).filled(:string)
          optional(:enabled).maybe(:bool)
          optional(:totp).maybe(:bool)
          optional(:email).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:email_verified).maybe(:bool)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:password).maybe(:string)
          optional(:attributes).maybe(:hash)
          optional(:roles).array(:string)
          optional(:groups).array(:string)
          optional(:access).maybe(:hash)
          optional(:not_before).maybe(:integer)
          optional(:created_at).maybe(:date_time)
        end
      end
    end
  end
end
