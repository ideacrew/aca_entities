# frozen_string_literal: true

module Qbo::Legacy

  class CustomerStatusContract < ApplicationContract

    json do

      required(:past_due).maybe(Qbo::Types::StrippedString)
      required(:previous_balance).maybe(Qbo::Types::StrippedString)
      required(:new_charges).maybe(Qbo::Types::StrippedString)
      required(:adjustments).maybe(Qbo::Types::StrippedString)
      required(:payments).maybe(Qbo::Types::StrippedString)
      required(:total_due).maybe(Qbo::Types::StrippedString)
      required(:statement_date).maybe(:date)
  
      required(:adjustment_items).array(:hash) do
        required(:amount).maybe(Qbo::Types::StrippedString)
        required(:name).maybe(Qbo::Types::StrippedString)
        required(:description).maybe(Qbo::Types::StrippedString)
        required(:posting_date).maybe(Qbo::Types::StrippedString)
        required(:is_passive_renewal).maybe(:bool)
      end
  
      required(:payment_history).array(:hash)

    end
  end
end
