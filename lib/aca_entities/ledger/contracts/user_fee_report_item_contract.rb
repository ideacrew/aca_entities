# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::UserFeeReportItem}
      class UserFeeReportItemContract < Contract
        params do
          optional(:sequence_value).value(:integer)
          required(:hios_id).value(:string)
          required(:customer_id).value(:string)
          required(:policy_subscriber_hbx_id).value(:string)
          required(:enrolled_member_hbx_id).value(:string)
          required(:enrolled_member_last_name).value(:string)
          required(:enrolled_member_first_name).value(:string)
          required(:exchange_assigned_policy_id).value(:string)
          required(:insurer_assigned_subscriber_id).maybe(AcaEntities::Types::StringOrNil)
          required(:insurer_policy_id).maybe(AcaEntities::Types::StringOrNil)
          required(:hbx_qhp_id).value(:string)
          required(:marketplace_segment_id).value(:string)
          required(:enrolled_member_billing_cycle_start_on).value(:date)
          required(:enrolled_member_billing_cycle_end_on).value(:date)
          required(:user_fee_item_kind).value(AcaEntities::Ledger::Types::UserFeeReportItemKind)
          required(:aptc_amount).value(:decimal)
          required(:enrolled_member_premium_amount).value(:decimal)
          required(:enrolled_member_user_fee_amount).value(:decimal)
          optional(:member_premium_amt).value(:decimal)
          optional(:policy_premium_amt).value(:decimal)
          required(:external_doc_reference).maybe(AcaEntities::Types::StringOrNil)
          required(:created_at).value(:date_time)
          required(:updated_at).value(:date_time)
        end
      end
    end
  end
end
