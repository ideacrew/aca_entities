# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        module Events
          # ProductDeliveryCases create event
          class CaseCreated < Sequent::Event
            attrs(
              last_updated_at: DateTime,
              case_reference: String,
              integrated_case_aggregate_id: String,
              meta: ::Curam::ValueObjects::Meta
            )
          end

          # ProductDeliveryCases update event
          class CaseUpdated < Sequent::Event
            attrs(
              last_updated_at: DateTime,
              integrated_case_aggregate_id: String,
              meta: ::Curam::ValueObjects::Meta
            )
          end
        end
      end
    end
  end
end