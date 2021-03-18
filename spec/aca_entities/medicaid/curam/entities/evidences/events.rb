# frozen_string_literal: true

module Ehs
  module Evidences
    module Events
      class IncomeEvidenceCreated < Sequent::Event
        attrs(
          category: String,
          kind: String,
          amount: BigDecimal,
          start_date: Date,
          end_date: Date,
          last_payment_date: Date,
          frequency: String,
          deduction_amount: BigDecimal,
          deduction_kind: String,
          integrated_case_aggregate_id: String,
          person_aggregate_id: String,
          evidence_aggregate_id: String,
          created_at: DateTime,
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          income_identifiers: array(::Ehs::ValueObjects::ExternalIdentifier),
          evidence_identifiers: array(::Ehs::ValueObjects::ExternalIdentifier),
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class IncomeEvidenceUpdated < Sequent::Event
        attrs(
          evidence_aggregate_id: String,
          category: String,
          kind: String,
          amount: BigDecimal,
          start_date: Date,
          end_date: Date,
          last_payment_date: Date,
          frequency: String,
          deduction_amount: BigDecimal,
          deduction_kind: String,
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class IncomeEvidenceUpdated < Sequent::Event
        attrs(
          category: String,
          kind: String,
          amount: BigDecimal,
          start_date: Date,
          end_date: Date,
          last_payment_date: Date,
          frequency: String,
          deduction_amount: BigDecimal,
          deduction_kind: String,
          evidence_aggregate_id: String,
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class EvidenceCreated < Sequent::Event
        attrs(
          integrated_case_aggregate_id: String,
          person_aggregate_id: String,
          created_at: DateTime,
          last_updated_at: DateTime,
          evidence_status: String,
          evidence_data_id: String,
          evidence_data_type: String,
          version: String,
          identifiers: array(::Ehs::ValueObjects::ExternalIdentifier),
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class EvidenceUpdated < Sequent::Event
        attrs(
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end