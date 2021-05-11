# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::TaxHousehold}
      class TaxHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Float] :max_aptc optional
        # @option opts [Integer] :csr optional
        # @option opts [String] :is_insurance_assistance_eligible optional
        # @option opts [Array] :tax_household_members optional
        # @return [Dry::Monads::Result]
        params do
          optional(:max_aptc).maybe(:float)
          optional(:csr).maybe(:integer)
          optional(:is_insurance_assistance_eligible).maybe(Types::IaEligibilityKind)
          optional(:tax_household_members).array(TaxHouseholdMemberContract.params)

          optional(:tax_household_income).maybe(:float)
        end
      end
    end
  end
end
