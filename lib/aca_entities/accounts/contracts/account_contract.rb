# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating a Single Sign-on (SSO) identity assigned to a person
      # or service for use across multiple client services.  In Keycloak this is a Realm-level User
      class AccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Account}
        # @option opts [String] :id A unique identifier
        # @option opts [String] :username A user-defined unique identifier
        # @option opts [Boolean] :enabled Flag indicating whether the account is active
        # @option opts [String] :email An email addresss associated with the account
        # @option opts [String] :email_verified Flag indicating the email addresss is validated
        # @option opts [String] :first_name The account user's first name
        # @option opts [String] :last_name The account user's last name or system service name
        # @option opts [String] :password Credentials that meet system complexity policies
        # @option opts [String] :attributes Custom key/value pairs
        # @option opts [String] :realm_roles Realm-level access and permissions for this account
        # @option opts [String] :client_roles Client-level access and permissions for this account
        # @option opts [String] :groups Hiearchical attributes and role mappings for this account
        # @option opts [Hash] :access
        # @option opts [Hash] :profile Account-managed client configurtion settings
        # @option opts [Integer] :not_before
        # @option opts [DateTime] :created_at Timestamp when this account was created
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          optional(:username).filled(:string)
          optional(:enabled).maybe(:bool)
          optional(:totp).maybe(:bool)
          optional(:email).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:email_verified).maybe(:bool)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:password).maybe(:string)
          optional(:attributes).hash(AttributesContract.params)
          optional(:realm_roles).array(:string)
          optional(:client_roles).array(:string)
          optional(:groups).array(:string)
          optional(:access).maybe(:hash)
          optional(:profiles).maybe(:array)
          optional(:not_before).maybe(:integer)
          optional(:created_at).maybe(:date_time)
        end

        rule(:attributes) do
          if key? && value
            if value.is_a?(Hash)
              result = AttributesContract.new.call(value)
              if result&.failure?
                key.failure(
                  text: 'invalid attributes',
                  error: result.errors.to_h
                )
              else
                values.merge!(attributes: result.to_h)
              end
            else
              key.failure(text: 'invalid attributes. Expected a hash.')
            end
          end
        end

        rule(:profiles).each do |index:|
          values.to_h[:profiles[index]]&.each_pair do |attr_key, attr_val|
            result = ProfileContract.new.call(attr_val)
            next unless result.failure?

            key([*path, attr_key]).failure(
              { text: 'error', code: result.errors.to_h }
            )
          end
        end
      end
    end
  end
end
