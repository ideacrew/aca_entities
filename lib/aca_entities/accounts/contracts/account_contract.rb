# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Schema and validation rules for {AcaEntities::Accounts::Account}
      class AccountContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Profile}
        # @option opts [String] :id  Local data store's unique identifier for this account
        # @option opts [String] :name Display name for the OAuth account. Usually a concatenation of first and last
        #   name of the account holder
        # @option opts [Array<AcaEntities::Accounts::Contracts::IdentityContract>] :identitiesA list of authentication
        #   Provider identities associated with this account
        # @option opts [AcaEntities::Accounts::Profile] :profile Individual person or system account holder's
        #   preference settings
        # @option opts [AcaEntities::Types::EmailOrNil] :email Preferred email address for the account_holder to
        #   receive communications
        # @option opts [Integer] :sign_in_count The number of times this account has been authenticated on this
        #   service
        # @option opts [AcaEntities::Types::TimeOrNil] :current_sign_in_at The timestamp when the current session
        #   for this account started
        # @option opts [String] :current_sign_in_ip The IP address for the current session for this account
        # @option opts [[AcaEntities::Types::TimeOrNil] :last_sign_in_at The timestamp when the most recent
        #   session for this account started
        # @option opts [String] :last_sign_in_ip The IP address for the most recent session for this account started
        # @option opts [AcaEntities::Types::TimeOrNil] :created_at The timestamp when this record was originally
        #   created in the data store
        # @option opts [AcaEntities::Types::TimeOrNil] :updated_at The timestamp when this record was last changed
        #   in the data store
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          required(:name).filled(:string)
          required(:identities).array(AcaEntities::Accounts::Contracts::IdentityContract.params)
          optional(:profile).maybe(AcaEntities::Accounts::Contracts::ProfileContract.params)
          optional(:email).maybe(AcaEntities::Types::EmailOrNil)
          optional(:sign_in_count).maybe(:integer)
          optional(:current_sign_in_at).maybe(AcaEntities::Types::TimeOrNil)
          optional(:current_sign_in_ip).maybe(:string)
          optional(:last_sign_in_at).maybe(AcaEntities::Types::TimeOrNil)
          optional(:last_sign_in_ip).maybe(:string)
          optional(:created_at).maybe(AcaEntities::Types::TimeOrNil)
          optional(:updated_at).maybe(AcaEntities::Types::TimeOrNil)
        end
      end
    end
  end
end
