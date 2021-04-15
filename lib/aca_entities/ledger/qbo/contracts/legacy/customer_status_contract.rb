# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Legacy
        # contract for Qbo customer status
        class CustomerStatusContract < ApplicationContract

          json do
            required(:past_due).maybe(Ledger::Qbo::Types::StrippedString)
            required(:previous_balance).maybe(Ledger::Qbo::Types::StrippedString)
            required(:new_charges).maybe(Ledger::Qbo::Types::StrippedString)
            required(:adjustments).maybe(Ledger::Qbo::Types::StrippedString)
            required(:payments).maybe(Ledger::Qbo::Types::StrippedString)
            required(:total_due).maybe(Ledger::Qbo::Types::StrippedString)
            required(:statement_date).maybe(:date)

            required(:adjustment_items).array(:hash) do
              required(:amount).maybe(Ledger::Qbo::Types::StrippedString)
              required(:name).maybe(Ledger::Qbo::Types::StrippedString)
              required(:description).maybe(Ledger::Qbo::Types::StrippedString)
              required(:posting_date).maybe(Ledger::Qbo::Types::StrippedString)
              required(:is_passive_renewal).maybe(:bool)
            end

            required(:payment_history).array(:hash)

          end
        end
      end
    end
  end
end
