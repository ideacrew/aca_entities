# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Employer}
      class EmployerContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :employer_name required
        # @option opts [String] :employer_id optional
        # @return [Dry::Monads::Result]
        params do
          required(:employer_name).filled(:string)
          optional(:employer_id).maybe(:string)
          optional(:employer_address).maybe(AcaEntities::Contracts::Locations::AddressContract.params)
          optional(:employer_phone).maybe(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
        end
      end
    end
  end
end
