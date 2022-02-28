# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::UserFeeReport}
      class UserFeeReportContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hios_id).value(:string)
          required(:user_fee_rate).value(:float)
          required(:billing_cycle_date).value(:date)
          required(:premium_amount_total).value(:decimal)
          required(:user_fee_amount_total).value(:decimal)
          required(:adjustment_amount_total).value(:decimal)
          required(:user_fee_amount_due).value(:decimal)
          optional(:user_fee_report_items).array(AcaEntities::Ledger::Contracts::UserFeeReportItemContract.params)
          optional(:report_timestamp).maybe(:date_time)
          optional(:due_date).maybe(:date)
        end
      end
    end
  end
end
