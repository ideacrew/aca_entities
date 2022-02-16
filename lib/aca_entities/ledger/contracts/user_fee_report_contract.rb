# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::UserFeeReport}
      class UserFeeReportContract < Contract
        params do
          required(:id).value(:string)
          required(:issuer_id).value(:string)
          required(:billing_cycle_year).value(:string)
          required(:billing_cycle_month).value(:string)
          required(:premium_amount_total).value(:float)
          required(:fee_amount_total).value(:float)
          required(:adjustment_amount_total).value(:float)
          required(:fee_amount_due).value(:float)
          optional(:user_fee_report_items).array(AcaEntities::Ledger::Contracts::UserFeeReportItemContract.params)
          required(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
