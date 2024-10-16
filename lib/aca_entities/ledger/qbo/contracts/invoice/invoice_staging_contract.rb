# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Invoice
        # contract for Qbo Invoice staging
        class InvoiceStagingContract < ApplicationContract

          json do
            required(:sub_customer_last_name).maybe(:string)
            required(:sub_customer_external_id).maybe(:string)
            required(:customer_external_id).maybe(:string)
            required(:plan_name).maybe(:string)
            required(:coverage_type).maybe(:string)
            required(:premium_amount).maybe(:float)
            required(:benefit_begin_date).maybe(:date)
          end
        end
      end
    end
  end
end