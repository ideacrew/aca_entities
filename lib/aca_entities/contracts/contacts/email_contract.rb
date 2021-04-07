# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Contacts
      # Schema and validation rules for {AcaEntities::Contacts::Email}
      class EmailContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [String] :address required
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(
            AcaEntities::Types::EmailKinds
          )
          required(:address).filled(:string)
        end
      end
    end
  end
end
