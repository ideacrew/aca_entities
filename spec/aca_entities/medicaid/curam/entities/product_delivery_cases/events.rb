# frozen_string_literal: true

module Ehs
  module ProductDeliveryCases
    module Events
      class CaseCreated < Sequent::Event
        attrs(
          last_updated_at: DateTime,
          case_reference: String,
          integrated_case_aggregate_id: String,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class CaseUpdated < Sequent::Event
        attrs(
          last_updated_at: DateTime,
          integrated_case_aggregate_id: String,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end