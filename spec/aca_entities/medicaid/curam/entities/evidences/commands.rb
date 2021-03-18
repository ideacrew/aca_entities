# frozen_string_literal: true

module Ehs
  module Evidences
    module Commands
      class CreateIncomeEvidence < Sequent::Command
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
          created_at: DateTime,
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          income_identifiers: array(::Ehs::ValueObjects::ExternalIdentifier),
          evidence_identifiers: array(::Ehs::ValueObjects::ExternalIdentifier),
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdateIncomeEvidence < Sequent::Command
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
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end

      class CreateEvidence < Sequent::Command
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

        include ::Ehs::Commands::QuackLikeAnOperation
      end

      class UpdateEvidence < Sequent::Command
        attrs(
          last_updated_at: DateTime,
          evidence_status: String,
          version: String,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end