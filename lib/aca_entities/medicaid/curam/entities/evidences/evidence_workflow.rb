# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        # curam workflow evidence
        class EvidenceWorkflow < Sequent::Workflow
          on Events::IncomeEvidenceCreated do |event|
            event.income_identifiers.each do |external_id|
              ::Curam::Identifiers::Commands::CreateId.call({
                                                              key: external_id.key,
                                                              item: external_id.item,
                                                              start_on: external_id.start_on,
                                                              identifiable_id: event.aggregate_id,
                                                              identifiable_type: "Curam::Evidences::IncomeEvidenceRecord"
                                                            })
            end
            ::Curam::Evidences::Commands::CreateEvidence.call({
                                                                aggregate_id: event.evidence_aggregate_id,
                                                                integrated_case_aggregate_id: event.integrated_case_aggregate_id,
                                                                person_aggregate_id: event.person_aggregate_id,
                                                                evidence_aggregate_id: Sequent.new_uuid,
                                                                created_at: event.created_at,
                                                                last_updated_at: event.last_updated_at,
                                                                evidence_status: event.evidence_status,
                                                                evidence_data_id: event.aggregate_id,
                                                                evidence_data_type: "Curam::Evidences::IncomeEvidenceRecord",
                                                                version: event.version,
                                                                identifiers: event.evidence_identifiers,
                                                                meta: event.meta
                                                              })
          end

          on Events::IncomeEvidenceUpdated do |event|
            ::Curam::Evidences::Commands::UpdateEvidence.call({
                                                                aggregate_id: event.evidence_aggregate_id,
                                                                last_updated_at: event.last_updated_at,
                                                                evidence_status: event.evidence_status,
                                                                version: event.version,
                                                                meta: event.meta
                                                              })
          end

          on Events::EvidenceCreated do |event|
            event.identifiers.each do |external_id|
              ::Curam::Identifiers::Commands::CreateId.call({
                                                              key: external_id.key,
                                                              item: external_id.item,
                                                              start_on: external_id.start_on,
                                                              identifiable_id: event.aggregate_id,
                                                              identifiable_type: "Curam::Evidences::EvidenceRecord"
                                                            })
            end
          end
        end
      end
    end
  end
end