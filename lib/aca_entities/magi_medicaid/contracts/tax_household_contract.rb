# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for TaxHousehold
      class TaxHouseholdContract < Dry::Validation::Contract

        params do

          optional(:max_aptc).maybe(:float)
          optional(:csr).maybe(:integer)
          optional(:is_insurance_assistance_eligible).maybe(Types::IaEligibilityKind)
          optional(:tax_household_members).maybe(:array)
        end

        rule(:tax_household_members).each do
          if key? && value
            if value.is_a?(Hash)
              result = TaxHouseholdMemberContract.new.call(value)
              key.failure(text: "invalid tax household member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid tax household member. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
