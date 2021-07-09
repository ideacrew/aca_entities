# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for ReferralActivity
      class ReferralActivity < Dry::Struct

        attribute :activity_id, ActivityIdentification.meta(omittable: false)
        attribute :activity_date, ActivityDate.meta(omittable: false)
        attribute :sender_reference, ReferralActivitySenderReference.meta(omittable: false)
        attribute :receiver_reference, ReferralActivityReceiverReference.meta(omittable: false)
        attribute :activity_identification, ActivityIdentification.optional.meta(omittable: true)
        attribute :reason_code, Types::String.optional.meta(omittable: true)
        attribute :status, ReferralActivityStatus.optional.meta(omittable: true)
        # attribute :eligibility_reason_reference, ReferralActivityEligibilityReasonReference.optional.meta(omittable: true)
      end
    end
  end
end
