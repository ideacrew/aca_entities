# frozen_string_literal: true

module Ehs
  module CaseDecisions
    class AggregateRoot < Sequent::AggregateRoot
      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::CaseDecisionCreated,
          {
            aggregate_id: command.aggregate_id,
            integrated_case_aggregate_id: command.integrated_case_aggregate_id,
            product_delivery_case_aggregate_id: command.product_delivery_case_aggregate_id,
            application_aggregate_id: command.application_aggregate_id,
            program_application_aggregate_id: command.program_application_aggregate_id,
            person_aggregate_id: command.person_aggregate_id,
            product_name: command.product_name,
            product_kind: command.product_kind,
            start_date: command.start_date,
            end_date: command.end_date,
            frequency: command.frequency,
            amount: command.amount,
            delivery_method: command.delivery_method,
            determination_datetime: command.determination_datetime,
            last_updated_at: command.last_updated_at,
            meta: command.meta
          }
        )
      end

      def update(command)
        if command.last_updated_at > @last_updated_at
          apply(
            Events::CaseDecisionUpdated,
            {
              aggregate_id: command.aggregate_id,
              product_name: command.product_name,
              product_kind: command.product_kind,
              start_date: command.start_date,
              end_date: command.end_date,
              frequency: command.frequency,
              amount: command.amount,
              delivery_method: command.delivery_method,
              determination_datetime: command.determination_datetime,
              last_updated_at: command.last_updated_at,
              meta: command.meta
            }
          )
        end
      end

      on Events::CaseDecisionCreated do |event|
        @integrated_case_aggregate_id = event.integrated_case_aggregate_id,
        @product_delivery_case_aggregate_id = event.product_delivery_case_aggregate_id
        @application_aggregate_id = event.application_aggregate_id
        @program_application_aggregate_id = event.program_application_aggregate_id
        @person_aggregate_id = event.person_aggregate_id
        @product_name = event.product_name
        @product_kind = event.product_kind
        @start_date = event.start_date
        @end_date = event.end_date
        @frequency = event.frequency
        @amount = event.amount
        @delivery_method = event.delivery_method
        @determination_datetime = event.determination_datetime
        @last_updated_at = event.last_updated_at
      end

      on Events::CaseDecisionUpdated do |event|
        @product_name = event.product_name
        @product_kind = event.product_kind
        @start_date = event.start_date
        @end_date = event.end_date
        @frequency = event.frequency
        @amount = event.amount
        @delivery_method = event.delivery_method
        @determination_datetime = event.determination_datetime
        @last_updated_at = event.last_updated_at
      end
    end
  end
end
  