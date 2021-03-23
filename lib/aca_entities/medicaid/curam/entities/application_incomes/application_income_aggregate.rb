# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        # ApplicationIncomeAggregate
        class ApplicationIncomeAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::ApplicationIncomeCreated,
              {
                aggregate_id: command.aggregate_id,
                category: command.category,
                status: command.status,
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
                last_payment_date: command.last_payment_date
              }
            )
          end

          def update_attributes(command)
            if (command.version.to_i > @version.to_i) && (command.status != 'Deleted')
              apply(
                Events::ApplicationIncomeUpdated,
                {
                  aggregate_id: command.aggregate_id,
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
                  last_payment_date: command.last_payment_date
                }
              )
            elsif (command.version.to_i >= @version.to_i) && (command.status == 'Deleted') && (command.status != @status)
              apply(
                Events::ApplicationIncomeDeleted,
                {
                  aggregate_id: command.aggregate_id,
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
                  last_payment_date: command.last_payment_date
                }
              )
            end
          end

          on Events::ApplicationIncomeCreated do |event|
            @category = event.category
            @status = event.status
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

          on Events::ApplicationIncomeUpdated do |event|
            @category = event.category
            @status = event.status
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

          on Events::ApplicationIncomeDeleted do |event|
            @category = event.category
            @status = event.status
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
        # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
      end
    end
  end
end