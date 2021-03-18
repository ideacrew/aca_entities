module Ehs
  module FinancialStatements
    class IncomeValueObject < Sequent::ValueObject
      attrs(
        amount: BigDecimal,
        kind: String,
        frequency: String,
        start_date: Date,
        end_date: Date
      )
    end
  end
end