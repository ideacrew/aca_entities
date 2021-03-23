# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        # Evidence Aggregate
        class EvidenceAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::EvidenceCreated,
              {
                aggregate_id: command.aggregate_id,
                integrated_case_aggregate_id: command.integrated_case_aggregate_id,
                person_aggregate_id: command.person_aggregate_id,
                created_at: command.created_at,
                last_updated_at: command.last_updated_at,
                evidence_status: command.evidence_status,
                evidence_data_id: command.evidence_data_id,
                evidence_data_type: command.evidence_data_type,
                version: command.version,
                identifiers: command.identifiers,
                meta: command.meta
              }
            )
          end

          def update(command)
            return unless command.last_updated_at > @last_updated_at

            apply(
              Events::EvidenceUpdated,
              {
                aggregate_id: command.aggregate_id,
                last_updated_at: command.last_updated_at,
                evidence_status: command.evidence_status,
                version: command.version,
                meta: command.meta
              }
            )
          end

          on Events::EvidenceCreated do |event|
            @integrated_case_aggregate_id = event.integrated_case_aggregate_id,
                                            @person_aggregate_id = event.person_aggregate_id
            @created_at = event.created_at
            @last_updated_at = event.last_updated_at
            @evidence_status = event.evidence_status
            @evidence_data_id = event.evidence_data_id
            @evidence_data_type = event.evidence_data_type
            @version = event.version
          end

          on Events::EvidenceUpdated do |event|
            @last_updated_at = event.last_updated_at
            @evidence_status = event.evidence_status
            @version = event.version
          end
        end
      end
    end
  end
end