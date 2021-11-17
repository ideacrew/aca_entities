# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for MedicaidHousehold
      class MedicaidHouseholdContract < Dry::Validation::Contract

        params do
          optional(:household_incomes).maybe(:array)
          optional(:effective_person_quantity).maybe(:integer)
          optional(:income_above_highest_applicable_magi_standard_indicator).maybe(:bool)
          optional(:household_member_references).maybe(:array)
          optional(:household_size_quantity).maybe(:integer)
        end
      end
    end
  end
end
