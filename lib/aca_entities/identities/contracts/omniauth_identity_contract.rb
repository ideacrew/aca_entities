# frozen_string_literal: true

module AcaEntities
  module Identities
    module Contracts
      # Contract for validating a {AcaEntities::Identities::Identity} entity
      class OmniauthIdentityContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Identities::OmniauthIdentity}
        # @option opts [String] :id System-assigned unique identifier
        # @option opts [String] :provider The service with which this identity is authenticated (required)
        # @option opts [String] :user_id An identifier unique to the given provider (required)
        # @option opts [String] :password Credentials that meet system complexity policies
        # @option opts [String] :name The display name - usually a concatenation of first and last name (required)
        # @option opts [Boolean] :enabled Flag indicating whether the user_id is active
        # @option opts [String] :email The email name of the authenticated identity
        # @option opts [Boolean] :email_verified Flag indicating the email addresss is validated
        # @option opts [String] :first_name The account user's first name
        # @option opts [String] :last_name The account user's last name or system service name
        # @option opts [AttributesContract] :attributes Custom key/value pairs
        # @option opts [AcaEntities::Contracts::TimeStampContract] :time_stamp Date and time when this record was created and last updated
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params(AcaEntities::Identities::Contracts::IdentityContract) do
          optional(:id).maybe(:string)
          required(:provider).filled(:string)
          required(:user_id).filled(:string)
          optional(:password).maybe(:string)
          optional(:email).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:email_verified).maybe(:bool)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:attributes).hash(AcaEntities::Identities::Contracts::AttributesContract.params)
        end

        rule(:email, :email_verified) do
          # rubocop:disable Style/IfUnlessModifier
          if values[:email_verified] && (key?(:email) && values[:email].empty?)
            key.failure('empty email must not be verified')
          end
          # rubocop:enable Style/IfUnlessModifier
        end

        rule(:attributes) do
          if key? && value
            if value.is_a?(Hash)
              result = AttributesContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid attributes', error: result.errors.to_h)
              else
                values.merge!(attributes: result.to_h)
              end
            else
              key.failure(text: 'invalid attributes. Expected a hash.')
            end
          end
        end
      end
    end
  end
end
