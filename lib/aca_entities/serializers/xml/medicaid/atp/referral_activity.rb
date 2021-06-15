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
          end
        end
      end
    end
  end
end