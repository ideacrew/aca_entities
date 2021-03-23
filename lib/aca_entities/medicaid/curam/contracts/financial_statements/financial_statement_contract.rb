# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module FinancialStatements
        # contract for FinancialStatement
        class FinancialStatementContract < Curam::ApplicationContract

          params do
            required(:tax_filing_status).filled(:string)
            required(:is_tax_filing_together).filled(:bool)
            required(:incomes).array(:hash)
          end

          rule(:tax_filing_status) do
            key.failure(text: 'invalid tax_filing_status') if key? && value && !::Curam::TypesTaxFilingStatusKind.include?(value)
          end

          rule(:incomes) do
            if key? && value
              incomes_array = value.inject([]) do |hash_array, income_hash|
                if income_hash.is_a?(Hash)
                  result = IncomeContract.new.call(income_hash)
                  if result&.failure?
                    key.failure(text: 'invalid income', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid income. Expected a hash.')
                end
                hash_array
              end
              values.merge!(incomes: incomes_array)
            end
          end
        end
      end
    end
  end
end
