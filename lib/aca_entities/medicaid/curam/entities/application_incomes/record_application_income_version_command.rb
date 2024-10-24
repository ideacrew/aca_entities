# frozen_string_literal: true

require 'dry/monads'

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # RecordApplicationIncomeVersionCommand
        class RecordApplicationIncomeVersionCommand < Sequent::Command
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

          extend Dry::Monads[:result]

          # Special case here, we may get the same record multiple times -
          # Don't store it.
          def self.call(entity)
            check_string = [
              entity.category, entity.case_id, entity.application_id, entity.evidence_descriptor_id,
              entity.program_kind, entity.version, entity.status
            ].map(&:to_s).join("-")
            checksum = Digest::SHA2.new(512).hexdigest(check_string) + check_string.length.to_s
            application_income_check_string = [
              entity.category, entity.case_id, entity.application_id,
              entity.evidence_descriptor_id, entity.program_kind
            ].map(&:to_s).join("-")
            application_income_check_string_length = application_income_check_string.length.to_s
            application_income_checksum = Digest::SHA2.new(512).hexdigest(application_income_check_string) + application_income_check_string_length
            command = new(
              entity.attributes.merge({ aggregate_id: checksum,
                                        application_income_aggregate_id: application_income_checksum })
            )
            return Failure(command.errors) unless command.valid?
            if ApplicationIncomeVersionRecord.where({ aggregate_id: checksum }).any?
              Success(nil)
            else
              Sequent.command_service.execute_commands command
              Success(checksum)
            end
          end
        end
      end
    end
  end
end