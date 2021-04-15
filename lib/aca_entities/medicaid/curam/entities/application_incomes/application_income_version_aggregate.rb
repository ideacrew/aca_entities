# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeVersionAggregate
        class ApplicationIncomeVersionAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::ApplicationIncomeVersionRecorded,
              { aggregate_id: command.aggregate_id,
                application_income_aggregate_id: command.application_income_aggregate_id,
                status: command.status,
                category: command.category,
                case_id: command.case_id,
                case_reference: command.case_reference,
                evidence_descriptor_id: command.evidence_descriptor_id,
                application_id: command.application_id,
                program_kind: command.program_kind,
                case_kind: command.case_kind,
                amount: command.amount,
                frequency: command.frequency,
                start_date: command.start_date,
                end_date: command.end_date,
                kind: command.kind,
                version: command.version,
                created_on: command.created_on,
                last_update_on: command.last_update_on,
                deduction_amount: command.deduction_amount,
                last_payment_date: command.last_payment_date }
            )
          end

          on Events::ApplicationIncomeVersionRecorded do |event|
            @status = event.status
            @category = event.category
            @application_income_aggregate_id = event.application_income_aggregate_id
            @case_id = event.case_id
            @case_reference = event.case_reference
            @evidence_descriptor_id = event.evidence_descriptor_id
            @application_id = event.application_id
            @program_kind = event.program_kind
            @case_kind = event.case_kind
            @amount = event.amount
            @frequency = event.frequency
            @start_date = event.start_date
            @end_date = event.end_date
            @kind = event.kind
            @version = event.version
            @created_on = event.created_on
            @last_update_on = event.last_update_on
            @deduction_amount = event.deduction_amount
            @last_payment_date = event.last_payment_date
          end
        end
      end
    end
  end
end