# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::UserFeeReportItem}
      class UserFeeReportItemContract < Contract
        params do
          # required(:sequence_value).value(:integer)
          required(:hios_id).value(:string)
          required(:hbx_subscriber_id).value(:string)
          required(:hbx_member_id).value(:string)
          required(:insurer_subscriber_id).value(:string)
          required(:last_name).value(:string)
          required(:first_name).value(:string)
          required(:hbx_policy_id).value(:string)
          required(:hbx_qhp_id).value(:string)
          required(:marketplace_segment_id).value(:string)
          required(:insurer_policy_id).value(:string)
          required(:policy_aptc_amount).value(:float)
          required(:member_premium_amount).value(:float)
          required(:billing_start_on).value(:date)
          required(:billing_end_on).value(:date)
          required(:fee_kind).value(AcaEntities::Ledger::Types::UserFeeReportItemKind)
          required(:fee_amount).value(:float)
          required(:external_doc_reference).value(:string)
          required(:created_at).value(:date_time)
          required(:updated_at).value(:date_time)
        end
      end
    end
  end
end
