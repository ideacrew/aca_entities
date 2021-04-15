# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IntegratedCases
        # IntegratedCases CaseAggregate
        class CaseAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::CaseCreated,
              {
                aggregate_id: command.aggregate_id,
                case_reference: command.case_reference,
                meta: command.meta,
                case_kind: command.case_kind,
                esnap_flag: command.esnap_flag,
                last_updated: command.last_updated
              }
            )
          end

          def update(command)
            return unless @last_updated < command.last_updated

            apply(
              Events::CaseUpdated,
              {
                aggregate_id: command.aggregate_id,
                case_reference: command.case_reference,
                esnap_flag: command.esnap_flag,
                meta: command.meta,
                last_updated: command.last_updated
              }
            )
          end

          on Events::CaseCreated do |event|
            @last_updated = event.last_updated
            @case_reference = event.case_reference
            @case_kind = event.case_kind
            @esnap_flag = event.esnap_flag
          end

          on Events::CaseUpdated do |event|
            @last_updated = event.last_updated
            @case_reference = event.case_reference
            @esnap_flag = event.esnap_flag
          end
        end
      end
    end
  end
end
