# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IntegratedCases
        module Events
          # IntegratedCases created event
          class CaseCreated < Sequent::Event
            attrs(
              last_updated: DateTime,
              case_reference: String,
              case_kind: String,
              esnap_flag: Boolean,
              meta: ::Curam::ValueObjects::Meta
            )
          end

          class CaseUpdated < Sequent::Event
            attrs(
              last_updated: DateTime,
              case_reference: String,
              esnap_flag: Boolean,
              meta: ::Curam::ValueObjects::Meta
            )
          end
        end
      end
    end
  end
end
