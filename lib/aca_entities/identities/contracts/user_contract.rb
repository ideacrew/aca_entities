# frozen_string_literal: true

module AcaEntities
  module Identities
    module Contracts
      # Contract for validating {AcaEntities::Identities::User} entity
      class UserContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Account}
        # @option opts [String] :id Application-assigned unique identifier
        # @option opts [AcaEntities::Types::EmailAddressKind] :email An email addresss associated with the account
        # @option opts [Boolean] :email_verified Flag indicating the email addresss is validated
        # @option opts [Array<AcaEntities::Attestations::Attestation>] :attestations Attestations made by this user regarding proof of identity
        # @option opts [AcaEntities::Types::UriKind] :last_portal_visited A user-defined unique identifier
        # @option opts [AcaEntities::Identities::UserProfile] :profile User preferences and configuration settings
        # @option opts [AcaEntities::Contracts::TimeStampContract] :time_stamp Date and time when this record was created and last updated
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          required(:identity).filled(AcaEntities::Identities::Contracts::OmniauthIdentityContract.params)

          # optional(:person).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:attestations).array(AcaEntities::Attestations::AttestationContract.params)
          optional(:last_portal_visited).maybe(AcaEntities::Types::UriKind)
          optional(:user_profile).maybe(AcaEntities::Identities::Contracts::UserProfileContract.params)
          optional(:time_stamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
