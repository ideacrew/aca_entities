# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module FinancialStatements
        # contract for FinancialStatements income
        class IncomeContract < Curam::ApplicationContract
          params do
            required(:amount).filled(:decimal)
            required(:type).filled(:string)
            required(:frequency).filled(:string)
            required(:start_date).filled(:date)
            required(:end_date).filled(:date)
          end

          rule(:type) do
            key.failure(text: 'invalid type') if key? && value && !::Curam::TypesIncomeTypeKind.include?(value)
          end

          rule(:frequency) do
            key.failure(text: 'invalid frequency') if key? && value && !::Curam::TypesIncomeFrequencyKind.include?(value)
          end
        end
      end
    end
  end
end
