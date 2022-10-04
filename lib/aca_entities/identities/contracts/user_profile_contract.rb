# frozen_string_literal: true

module AcaEntities
  module Identities
    # contract for Accounts user
    module Contracts
      # Contract for validating an {AcaEntities::Accounts::Profile}
      # with customized option configuration
      class UserProfileContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::Account}
        # @option opts [String] :locale Preferred system-supported language in ISO 639 encoding
        # @option opts [String] :communication_preference Preferred method of receiving system notices
        # @option opts [String] :electronic_communication_method System-supported electronic communication methods
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation

        params do
          optional(:client_key).maybe(AcaEntities::Types::ClientKinds)
          optional(:settings).hash do
            optional(:locale).maybe(::AcaEntities::Types::LocaleKinds)
            optional(:communication_preference).maybe(::AcaEntities::Types::CommunicationKinds)
            optional(:electronic_communication_method).maybe(::AcaEntities::Types::ElectronicCommunicationKinds)
          end
        end
      end
    end
  end
end
