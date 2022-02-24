# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Product}
    class UserFeeReportItem < Dry::Struct
      # include ::AcaEntities::Operations::Mongoid::ModelAdapter

      attribute? :sequence_value, Types::Integer.meta(omittable: true)
      attribute :hios_id, Types::String.meta(omittable: false)
      attribute :customer_id, Types::String.meta(omittable: false)
      attribute :policy_subscriber_hbx_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_hbx_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_last_name, Types::String.meta(omittable: false)
      attribute :enrolled_member_first_name, Types::String.meta(omittable: false)
      attribute :exchange_assigned_policy_id, Types::String.meta(omittable: false)
      attribute :insurer_assigned_subscriber_id, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :insurer_policy_id, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :hbx_qhp_id, Types::String.meta(omittable: false)
      attribute :marketplace_segment_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_billing_cycle_start_on, Types::Date.meta(omittable: false)
      attribute :enrolled_member_billing_cycle_end_on, Types::Date.meta(omittable: false)
      attribute :user_fee_item_kind, ::AcaEntities::Ledger::Types::UserFeeReportItemKind.meta(omittable: false)
      attribute :aptc_amount, Types::Decimal.meta(omittable: false)
      attribute :enrolled_member_premium_amount, Types::Decimal.meta(omittable: false)
      attribute :enrolled_member_user_fee_amount, Types::Decimal.meta(omittable: false)
      attribute :external_doc_reference, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :created_at, Types::DateTime.meta(omittable: false)
      attribute :updated_at, Types::DateTime.meta(omittable: false)
    end
  end
end
