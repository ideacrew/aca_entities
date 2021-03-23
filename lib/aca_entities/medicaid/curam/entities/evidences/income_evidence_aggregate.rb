# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        # IncomeEvidence Aggregate
        class IncomeEvidenceAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::IncomeEvidenceCreated,
              { aggregate_id: command.aggregate_id,
                category: command.category,
                kind: command.kind,
                amount: command.amount,
                start_date: command.start_date,
                end_date: command.end_date,
                last_payment_date: command.last_payment_date,
                frequency: command.frequency,
                deduction_amount: command.deduction_amount,
                deduction_kind: command.deduction_kind,
                integrated_case_aggregate_id: command.integrated_case_aggregate_id,
                person_aggregate_id: command.person_aggregate_id,
                evidence_aggregate_id: Sequent.new_uuid,
                created_at: command.created_at,
                last_updated_at: command.last_updated_at,
                evidence_status: command.evidence_status,
                version: command.version,
                income_identifiers: command.income_identifiers,
                evidence_identifiers: command.evidence_identifiers,
                meta: command.meta }
            )
          end

          def update(command)
            return unless command.last_updated_at > @last_updated_at

            apply(
              Events::IncomeEvidenceUpdated,
              {
                aggregate_id: command.aggregate_id,
                category: command.category,
                kind: command.kind,
                amount: command.amount,
                start_date: command.start_date,
                end_date: command.end_date,
                last_payment_date: command.last_payment_date,
                frequency: command.frequency,
                deduction_amount: command.deduction_amount,
                deduction_kind: command.deduction_kind,
                evidence_aggregate_id: @evidence_aggregate_id,
                last_updated_at: command.last_updated_at,
                evidence_status: command.evidence_status,
                version: command.version,
                meta: command.meta
              }
            )
          end

          on Events::IncomeEvidenceCreated do |event|
            @evidence_aggregate_id = event.evidence_aggregate_id
            @last_updated_at = event.last_updated_at
            @category = event.category
            @kind = event.kind
            @amount = event.amount
            @start_date = event.start_date
            @end_date = event.end_date
            @last_payment_date = event.last_payment_date
            @frequency = event.frequency
            @deduction_amount = event.deduction_amount
            @deduction_kind = event.deduction_kind
          end

          on Events::IncomeEvidenceUpdated do |event|
            @last_updated_at = event.last_updated_at
            @category = event.category
            @kind = event.kind
            @amount = event.amount
            @start_date = event.start_date
            @end_date = event.end_date
            @last_payment_date = event.last_payment_date
            @frequency = event.frequency
            @deduction_amount = event.deduction_amount
            @deduction_kind = event.deduction_kind
          end
        end
      end
    end
  end
end