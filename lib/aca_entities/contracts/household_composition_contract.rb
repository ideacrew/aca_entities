# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for HouseholdComposition.
    class HouseholdCompositionContract < Dry::Validation::Contract

      params do
        optional(:medicaid_household_size).maybe(:integer)
        optional(:qualified_children_list).maybe(:string)
      end

      rule(:medicaid_household_size) do
        if key?
          # required if Medicaid Houshold Status Indicator is not null
          # implement this once eligibility entities are defined
        end
      end

    end
  end
end
