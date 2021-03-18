# frozen_string_literal: true

module Ehs
  module ProductDeliveryCases
    class ProductDeliveryCaseAggregate < Sequent::AggregateRoot

      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::CaseCreated,
          {
            aggregate_id: command.aggregate_id,
            last_updated_at: command.last_updated_at,
            case_reference: command.case_reference,
            integrated_case_aggregate_id: command.integrated_case_aggregate_id,
            meta: command.meta
          }
        )
      end

      def update(command)
        if command.last_updated_at > @last_updated_at
          apply(
            Events::CaseUpdated,
            {
              aggregate_id: command.aggregate_id,
              last_updated_at: command.last_updated_at,
              integrated_case_aggregate_id: command.integrated_case_aggregate_id,
              meta: command.meta
            }
          )
        end
      end

      on Events::CaseCreated do |event|
        @last_updated_at = event.last_updated_at
        @case_reference = event.case_reference
        @integrated_case_aggregate_id = event.integrated_case_aggregate_id
      end

      on Events::CaseUpdated do |event|
        @last_updated_at = event.last_updated_at
        @integrated_case_aggregate_id = event.integrated_case_aggregate_id
      end
    end
  end
end