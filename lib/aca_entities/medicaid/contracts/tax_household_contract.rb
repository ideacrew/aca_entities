# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for TaxHousehold
      class TaxHouseholdContract < Dry::Validation::Contract

        params do
          required(:household_incomes).array(:hash)
          optional(:household_size_change_expected_indicator).maybe(:bool)
          optional(:primary_tax_filer).maybe(:hash)
          optional(:spouse_tax_filer).maybe(:hash)
          optional(:tax_dependents).maybe(:array)
          optional(:household_member_references).maybe(:array)
          optional(:household_size_quantity).maybe(:integer)
        end
      end
    end
  end
end