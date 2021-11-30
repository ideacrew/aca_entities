# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a referral of an insurance applicant from one information exchange system to another.
          class ReferralActivity
            include HappyMapper

            tag 'ReferralActivity'
            namespace 'hix-ee'

            has_one :activity_id, ActivityIdentification
            has_one :activity_date, ActivityDate
            has_one :sender_reference, ReferralActivitySenderReference
            has_one :receiver_reference, ReferralActivityReceiverReference
            element :reason_code, String, tag: 'ReferralActivityReasonCode'
            has_one :status, ReferralActivityStatus
            has_many :eligibility_reason_reference, ReferralActivityEligibilityReasonReference

            def self.domain_to_mapper(referral_activity)
              mapper = self.new
              mapper.activity_id = ActivityIdentification.domain_to_mapper(referral_activity.activity_id)
              mapper.activity_date = ActivityDate.domain_to_mapper(referral_activity.activity_date)
              mapper.sender_reference = ReferralActivitySenderReference.domain_to_mapper(referral_activity.sender_reference)
              mapper.receiver_reference = ReferralActivityReceiverReference.domain_to_mapper(referral_activity.receiver_reference)
              mapper.status = ReferralActivityStatus.domain_to_mapper(referral_activity.status)
              mapper.reason_code = referral_activity.reason_code
              mapper
            end

            def to_hash
              {
                activity_date: activity_date&.to_hash,
                activity_id: activity_id&.to_hash,
                reason_code: reason_code,
                receiver_reference: receiver_reference&.to_hash,
                sender_reference: sender_reference&.to_hash,
                status: status&.to_hash,
                eligibility_reason_reference: eligibility_reason_reference.map(&:to_hash)
              }
            end
          end
        end
      end
    end
  end
end