# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeProjector
        class ApplicationIncomeProjector < Sequent::Projector
          manages_tables ApplicationIncomeVersionRecord, ApplicationIncomeRecord

          on Events::ApplicationIncomeVersionRecorded do |event|
            create_record(
              ApplicationIncomeVersionRecord,
              {
                aggregate_id: event.aggregate_id,
                application_income_aggregate_id: event.application_income_aggregate_id,
                status: event.status,
                category: event.category,
                case_id: event.case_id,
                case_reference: event.case_reference,
                evidence_descriptor_id: event.evidence_descriptor_id,
                application_id: event.application_id,
                program_kind: event.program_kind,
                case_kind: event.case_kind,
                amount: event.amount,
                frequency: event.frequency,
                start_date: event.start_date,
                end_date: event.end_date,
                kind: event.kind,
                version: event.version,
                created_on: event.created_on,
                last_update_on: event.last_update_on,
                deduction_amount: event.deduction_amount,
                last_payment_date: event.last_payment_date
              }
            )
          end

          on Events::ApplicationIncomeCreated do |event|
            create_record(
              ApplicationIncomeRecord,
              {
                aggregate_id: event.aggregate_id,
                category: event.category,
                status: event.status,
                case_id: event.case_id,
                case_reference: event.case_reference,
                evidence_descriptor_id: event.evidence_descriptor_id,
                application_id: event.application_id,
                program_kind: event.program_kind,
                case_kind: event.case_kind,
                amount: event.amount,
                frequency: event.frequency,
                start_date: event.start_date,
                end_date: event.end_date,
                kind: event.kind,
                version: event.version,
                created_on: event.created_on,
                last_update_on: event.last_update_on,
                deduction_amount: event.deduction_amount,
                last_payment_date: event.last_payment_date
              }
            )
          end

          on Events::ApplicationIncomeUpdated do |event|
            update_all_records(
              ApplicationIncomeRecord,
              { aggregate_id: event.aggregate_id },
              {
                category: event.category,
                status: event.status,
                case_id: event.case_id,
                case_reference: event.case_reference,
                evidence_descriptor_id: event.evidence_descriptor_id,
                application_id: event.application_id,
                program_kind: event.program_kind,
                case_kind: event.case_kind,
                amount: event.amount,
                frequency: event.frequency,
                start_date: event.start_date,
                end_date: event.end_date,
                kind: event.kind,
                version: event.version,
                created_on: event.created_on,
                last_update_on: event.last_update_on,
                deduction_amount: event.deduction_amount,
                last_payment_date: event.last_payment_date
              }
            )
          end

          on Events::ApplicationIncomeDeleted do |event|
            update_all_records(
              ApplicationIncomeRecord,
              { aggregate_id: event.aggregate_id },
              {
                category: event.category,
                status: event.status,
                case_id: event.case_id,
                case_reference: event.case_reference,
                evidence_descriptor_id: event.evidence_descriptor_id,
                application_id: event.application_id,
                program_kind: event.program_kind,
                case_kind: event.case_kind,
                amount: event.amount,
                frequency: event.frequency,
                start_date: event.start_date,
                end_date: event.end_date,
                kind: event.kind,
                version: event.version,
                created_on: event.created_on,
                last_update_on: event.last_update_on,
                deduction_amount: event.deduction_amount,
                last_payment_date: event.last_payment_date
              }
            )
          end
        end
      end
    end
  end
end