# frozen_string_literal: true

module Ehs
  class FinancialStatements::Income < Dry::Struct

    attribute :amount,     Types::Decimal.meta(omittable: false)
    attribute :type,       Types::IncomeTypeKind.meta(omittable: false)
    attribute :frequency,  Types::IncomeFrequencyKind.meta(omittable: false)
    attribute :start_date, Types::Date.meta(omittable: false)
    attribute :end_date,   Types::Date.meta(omittable: false)
  end
end
