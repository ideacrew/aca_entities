require 'dry/monads'

module Ehs
  module ApplicationIncomes
    class CreateApplicationIncomeCommand < Sequent::Command
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
        unless command.valid?
          return Failure(command.errors)
        end
        if !ApplicationIncomeVersionRecord.where({aggregate_id: checksum}).any?
          Sequent.command_service.execute_commands command
          Success(checksum)
        else
          Success(nil)
        end
      end
    end
  end
end