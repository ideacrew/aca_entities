# frozen_string_literal: true

module Ehs::FinancialStatements
  class IncomeContract < Ehs::ApplicationContract
    params do
      required(:amount).filled(:decimal)
      required(:type).filled(:string)
      required(:frequency).filled(:string)
      required(:start_date).filled(:date)
      required(:end_date).filled(:date)
    end

    rule(:type) do
      key.failure(text: 'invalid type') if key? && value && !::Ehs::Types::IncomeTypeKind.include?(value)
    end

    rule(:frequency) do
      key.failure(text: 'invalid frequency') if key? && value && !::Ehs::Types::IncomeFrequencyKind.include?(value)
    end
  end
end
