# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::IdentifyingInformation}
      class IdentifyingInformationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :has_ssn required
        # @option opts [String] :encrypted_ssn optional
        # @return [Dry::Monads::Result]
        params do
          required(:has_ssn).filled(:bool)
          optional(:encrypted_ssn).maybe(:string)
          optional(:ssn).maybe(:string)
        end
      end
    end
  end
end