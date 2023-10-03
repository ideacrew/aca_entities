# frozen_string_literal: true

module AcaEntities
  module Accounts
    # Schema contract for individual person or system account holder's preference settings
    module Contracts
      # Contract for validating an {AcaEntities::Accounts::PersonProfile} parameters
      class PersonProfileContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Accounts::PersonProfile}
        # @option opts [String] :preferred_name The account_holder's informal name
        # @option opts [AcaEntities::Types::LocaleKinds] :locale Preferred system-supported language in ISO 639 encoding. Defaults to 'en'
        # @option opts [AcaEntities::Types::CommunicationKinds] :notice_delivery_method Preferred method of receiving system notices
        # @option opts [AcaEntities::Types::ElectronicCommunicationKinds] :electronic_communication_method System-supported electronic communication methods
        # @option opts [AcaEntities::Types::EmailOrNil] :email Preferred email address for the account_holder to receive communications
        # @option opts [AcaEntities::Types::NumbersOrNil] :mobile_phone Preferred mobile phone number for the account_holder
        # @option opts [Time] :created_at The timestamp when this record was originally created in the data store
        # @option opts [Time] :updated_at The timestamp when this record was last changed in the data store
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation

        params do
          required(:preferred_name).filled(:string)
          required(:locale).filled(AcaEntities::Types::LocaleKinds)
          required(:notice_delivery_method).filled(AcaEntities::Types::CommunicationKinds)
          required(:electronic_communication_method).filled(AcaEntities::Types::ElectronicCommunicationKinds)
          optional(:email).maybe(AcaEntities::Types::EmailOrNil)
          optional(:mobile_phone).maybe(AcaEntities::Types::NumbersOrNil)
          optional(:created_at).maybe(:time)
          optional(:updated_at).maybe(:time)
        end
      end
    end
  end
end
