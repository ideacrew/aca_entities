# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        module Events
          # Event entity for ApplicationIncomeUpdated
          class ApplicationIncomeUpdated < Sequent::Event
            attrs(
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
  end
end
