# frozen_string_literal: true

require 'dry/monads'

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # UpdateApplicationIncomeCommand
        class UpdateApplicationIncomeCommand < Sequent::Command
          attrs(
            category: String,
            case_id: String,
            status: String,
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

          extend Dry::Monads[:result]

          def self.call(attrs)
            command = new(
              attrs
            )
            return Failure(command.errors) unless command.valid?
            Sequent.command_service.execute_commands command
            Success(checksum)
          end
        end
      end
    end
  end
end