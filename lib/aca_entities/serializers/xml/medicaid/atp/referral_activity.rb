# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a referral of an insurance applicant from one information exchange system to another.
          class ReferralActivity
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'ReferralActivity'
            namespace 'hix-ee'

            has_one :activity_date, ActivityDate
            has_one :activity_id, ActivityIdentification
            element :reason_code, String, tag: 'ReferralActivityReasonCode'
            has_one :receiver_reference, ReferralActivityReceiverReference
            has_one :sender_reference, ReferralActivitySenderReference
            has_one :status, ReferralActivityStatus
            has_many :eligibility_reason_reference, ReferralActivityEligibilityReasonReference

            def self.domain_to_mapper(policy)
              mapper = self.new
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
                eligibility_reason_reference: eligibility_reason_reference.map(&:eligibility_reason_reference)
              }
            end
          end
        end
      end
    end
  end
end