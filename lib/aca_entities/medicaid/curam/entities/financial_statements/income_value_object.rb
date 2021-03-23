# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module FinancialStatements
        # FinancialStatements IncomeValueObject
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
  end
end