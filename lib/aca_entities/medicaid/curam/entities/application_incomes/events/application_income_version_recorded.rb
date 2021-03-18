module Ehs
  module ApplicationIncomes
    module Events
      class ApplicationIncomeVersionRecorded < Sequent::Event
        attrs(
          application_income_aggregate_id: String,
          category: String,
          status: String,
          case_id: String,
          case_reference: String,
          evidence_descriptor_id: String,
          application_id: String,
          program_kind: String,
          case_kind: String,
          amount: BigDecimal,
          frequency: String,
          start_date: Date,
          end_date: Date,
          kind: String,
          version: Integer,
          created_on: DateTime,
          last_update_on: DateTime,
          deduction_amount: BigDecimal,
          last_payment_date: Date
        )
      end
    end
  end
end
    