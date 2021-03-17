# frozen_string_literal: true

module Qbo::Items
  class ItemContract < ApplicationContract

    json do
      required(:Name).filled(Qbo::Types::StrippedString)
      required(:IncomeAccountRef).hash do 
        required(:value).filled(Qbo::Types::StrippedString)
      end
      required(:Type).filled(Qbo::Types::StrippedString)
    end
  end
end
