# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        module Commands
          # CreateIncomeEvidence command
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
              income_identifiers: array(::Curam::ValueObjects::ExternalIdentifier),
              evidence_identifiers: array(::Curam::ValueObjects::ExternalIdentifier),
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeACreateOperation
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
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
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
              identifiers: array(::Curam::ValueObjects::ExternalIdentifier),
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end

          class UpdateEvidence < Sequent::Command
            attrs(
              last_updated_at: DateTime,
              evidence_status: String,
              version: String,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end