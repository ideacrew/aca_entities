# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # type: A data type for An entity that started the referral activity.
          class TransferActivity
            include HappyMapper
            register_namespace 'ext', 'http://at.dsh.cms.gov/extension/1.0'

            tag 'TransferActivity'
            namespace 'ext'

            has_one :transfer_id, ActivityIdentification
            has_one :transfer_date, ActivityDate
            element :number_of_referrals, Integer, tag: "TransferActivityReferralQuantity", namespace: "ext"
            element :recipient_code, String, tag: "RecipientTransferActivityCode", namespace: "ext"
            element :state_code, String, tag: "RecipientTransferActivityStateCode", namespace: "ext"

            def self.domain_to_mapper(transfer_header)
              transfer_activity = self.new
              transfer_activity.transfer_id = ActivityIdentification.domain_to_mapper(transfer_header.transfer_id)
              transfer_activity.transfer_date = ActivityDate.domain_to_mapper(transfer_header.transfer_date)
              transfer_activity.number_of_referrals = transfer_header.number_of_referrals
              transfer_activity.recipient_code = transfer_header.recipient_code
              transfer_activity.state_code = transfer_header.state_code
              transfer_activity
            end

            def to_hash
              {
                transfer_id: transfer_id&.to_hash,
                transfer_date: transfer_date&.to_hash,
                number_of_referrals: number_of_referrals,
                recipient_code: recipient_code,
                state_code: state_code
              }
            end
          end
        end
      end
    end
  end
end