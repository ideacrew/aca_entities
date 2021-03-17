# frozen_string_literal: true

module Qbo::Legacy

  class PaymentHistoryContract < ApplicationContract

    json do 
      required(:amount).maybe(Qbo::Types::StrippedString)
      required(:reference_id).maybe(Qbo::Types::StrippedString)
      required(:paid_on).maybe(Qbo::Types::StrippedString)
      required(:method_kind).maybe(Qbo::Types::StrippedString)
    end
  end
end
