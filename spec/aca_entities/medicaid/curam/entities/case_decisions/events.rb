# frozen_string_literal: true

module Ehs
  module CaseDecisions
    module Events
      class CaseDecisionCreated < Sequent::Event
        attrs(
          integrated_case_aggregate_id: String,
          product_delivery_case_aggregate_id: String,
          application_aggregate_id: String,
          program_application_aggregate_id: String,
          person_aggregate_id: String,
          product_name: String,
          product_kind: String,
          start_date: Date,
          end_date: Date,
          frequency: String,
          amount: BigDecimal,
          delivery_method: String,
          determination_datetime: DateTime,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class CaseDecisionUpdated < Sequent::Event
        attrs(
          product_name: String,
          product_kind: String,
          start_date: Date,
          end_date: Date,
          frequency: String,
          amount: BigDecimal,
          delivery_method: String,
          determination_datetime: DateTime,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end