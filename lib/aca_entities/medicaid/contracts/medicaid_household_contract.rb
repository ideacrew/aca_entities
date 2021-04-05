# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for MedicaidHousehold
      class MedicaidHouseholdContract < Dry::Validation::Contract

        params do
          optional(:household_income).maybe(:hash)
          optional(:household_composition).maybe(:hash)
        end

        rule(:household_income) do
          if key? && value
            if value.is_a?(Hash)
              result = HouseholdIncomeContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid household income', error: result.errors.to_h)
              else
                values.merge!(household_income: result.to_h)
              end
            else
              key.failure(text: 'invalid household income. Expected a hash.')
            end
          end
        end

        rule(:household_composition) do
          if key? && value
            if value.is_a?(Hash)
              result = HouseholdCompositionContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid household composition', error: result.errors.to_h)
              else
                values.merge!(household_composition: result.to_h)
              end
            else
              key.failure(text: 'invalid household composition. Expected a hash.')
            end
          end
        end
      end
    end
  end
end
