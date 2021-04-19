# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Contacts
      # Schema and validation rules for {AcaEntities::Contacts::Email}
      class EmailContactContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [String] :address required
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(
            AcaEntities::Types::EmailKind
          )
          required(:address).filled do
            str? & format?(Types::EmailAddressRegex)
          end
          optional(:start_on).maybe(:string)
          optional(:end_on).maybe(:string)
        end
      end
    end
  end
end
