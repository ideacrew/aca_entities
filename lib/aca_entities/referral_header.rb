# frozen_string_literal: true

module AcaEntities
  # Entity for ReferralHeader information
  class ReferralHeader < Dry::Struct
    attribute :referral_id,                                    Types::String.optional.meta(omittable: true)
    attribute :referral_date,                                  Types::DateTime.optional.meta(omittable: true)
    attribute :evidence_documents_available,                   Types::Bool.optional.meta(omittable: true)
    attribute :referral_activity_reason,                       Types::String.optional.meta(omittable: true)
    attribute :referral_activity_eligibility,                  Types::String.optional.meta(omittable: true)
    attribute :referral_activity_status,                       Types::String.optional.meta(omittable: true)
    attribute :referral_activity_over_all_verification_status, Types::String.optional.meta(omittable: true)
    attribute :sender,                                         Sender.optional.meta(omittable: true)
    attribute :receiver,                                       Receiver.optional.meta(omittable: true)

  end
end
