# frozen_string_literal: true

require_relative "referral_activity_status"
require_relative "referral_activity_receiver_reference"
require_relative "referral_activity_sender_reference"
require_relative "referral_activity_eligibility_reason_reference"

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a referral of an insurance applicant from one information exchange system to another.
          class AdditionalReferralActivity
            include HappyMapper

            register_namespace 'me-atp', 'http://xmlns.coverme.gov/atp/hix-ee'
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'ReferralActivity'
            namespace 'me-atp'

            has_one :activity_id, ActivityIdentification
            has_one :activity_date, ActivityDate
            has_one :sender_reference, ReferralActivitySenderReference
            has_one :receiver_reference, ReferralActivityReceiverReference
            has_one :status, ReferralActivityStatus
            element :reason_code, String, tag: 'ReferralActivityReasonCode', namespace: "hix-ee"
            has_many :eligibility_reason_reference, ReferralActivityEligibilityReasonReference

            # As this is derived by extension, new elements must come last.
            has_many :additional_reason_codes, String, tag: 'AdditionalReferralActivityReasonCode', namespace: 'me-atp'

            def self.domain_to_mapper(referral_activity)
              mapper = self.new
              mapper.activity_id = ActivityIdentification.domain_to_mapper(referral_activity.activity_id)
              mapper.activity_date = ActivityDate.domain_to_mapper(referral_activity.activity_date)
              mapper.sender_reference = ReferralActivitySenderReference.domain_to_mapper(referral_activity.sender_reference)
              mapper.receiver_reference = ReferralActivityReceiverReference.domain_to_mapper(referral_activity.receiver_reference)
              mapper.status = ReferralActivityStatus.domain_to_mapper(referral_activity.status)
              other_reason_codes = referral_activity.additional_reason_codes || []
              mapper.reason_code = referral_activity.reason_code unless referral_activity.reason_code.blank?
              mapper.additional_reason_codes = other_reason_codes
              mapper
            end

            # TODO: ATP Inbound
            # def to_hash
            #   {
            #     activity_date: activity_date&.to_hash,
            #     activity_id: activity_id&.to_hash,
            #     reason_code: reason_code,
            #     receiver_reference: receiver_reference&.to_hash,
            #     sender_reference: sender_reference&.to_hash,
            #     status: status&.to_hash,
            #     eligibility_reason_reference: eligibility_reason_reference.map(&:to_hash)
            #   }
            # end
          end
        end
      end
    end
  end
end
