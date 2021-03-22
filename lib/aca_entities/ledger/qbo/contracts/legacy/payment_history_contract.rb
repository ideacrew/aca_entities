# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Legacy
        # contract for Qbo payment history
        class PaymentHistoryContract < ApplicationContract

          json do
            required(:amount).maybe(Ledger::Qbo::Types::StrippedString)
            required(:reference_id).maybe(Ledger::Qbo::Types::StrippedString)
            required(:paid_on).maybe(Ledger::Qbo::Types::StrippedString)
            required(:method_kind).maybe(Ledger::Qbo::Types::StrippedString)
          end
        end
      end
    end
  end
end
