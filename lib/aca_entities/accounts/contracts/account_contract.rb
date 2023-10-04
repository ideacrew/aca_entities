# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Schema and validation rules for {AcaEntities::Accounts::Account}
      class AccountContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Profile}
        # @option opts [String] :id  Local data store's unique identifier for this account
        # @option opts [String] :provider  An identifier for the third party OAuth service that authenticated this account
        # @option opts [String] :uid A Provider-assigned unique identifier for this account
        # @option opts [String] :name Display name for the OAuth account. Usually a concatenation of first and last name of the account holder
        # @option opts [AcaEntities::Accounts::Profile] :profile Individual person or system account holder's preference settings
        # @option opts [AcaEntities::Types::EmailOrNil] :email Preferred email address for the account_holder to receive communications
        # @option opts [String] :encrypted_password Encrypted password for the authenticated user
        # @option opts [AcaEntities::Types::TimeOrNil] :created_at The timestamp when this record was originally created in the data store
        # @option opts [AcaEntities::Types::TimeOrNil] :updated_at The timestamp when this record was last changed in the data store
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          required(:provider).filled(:string)
          required(:uid).filled(:string)
          required(:name).filled(:string)
          optional(:profile).maybe(AcaEntities::Accounts::Contracts::ProfileContract.params)
          optional(:email).maybe(AcaEntities::Types::EmailOrNil)
          optional(:encrypted_password).maybe(AcaEntities::Types::StringOrNil)
          optional(:created_at).maybe(AcaEntities::Types::TimeOrNil)
          optional(:updated_at).maybe(AcaEntities::Types::TimeOrNil)
        end
      end
    end
  end
end
