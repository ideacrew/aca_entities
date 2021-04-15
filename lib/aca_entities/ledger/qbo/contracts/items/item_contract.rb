# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Items
        # contract for Qbo item
        class ItemContract < ApplicationContract

          json do
            required(:Name).filled(Ledger::Qbo::Types::StrippedString)
            required(:IncomeAccountRef).hash do
              required(:value).filled(Ledger::Qbo::Types::StrippedString)
            end
            required(:Type).filled(Ledger::Qbo::Types::StrippedString)
          end
        end
      end
    end
  end
end
