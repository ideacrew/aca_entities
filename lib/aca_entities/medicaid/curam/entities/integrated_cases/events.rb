module Ehs
  module IntegratedCases
    module Events
      class CaseCreated < Sequent::Event
        attrs(
          last_updated: DateTime,
          case_reference: String,
          case_kind: String,
          esnap_flag: Boolean,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class CaseUpdated < Sequent::Event
        attrs(
          last_updated: DateTime,
          case_reference: String,
          esnap_flag: Boolean,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end
