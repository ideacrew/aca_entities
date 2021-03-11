# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for ReferralHeader.
    class ReferralHeaderContract < Dry::Validation::Contract

      params do
        optional(:referral_id).maybe(:string)
        optional(:referral_date).maybe(:date_time)
        optional(:evidence_documents_available).maybe(:bool)
        optional(:referral_activity_reason).maybe(Iap::Types::ReferralActivityReasonCode)
        optional(:referral_activity_eligibility).maybe(:string)
        optional(:referral_activity_status).maybe(Iap::Types::ReferralActivityStatusCode)
        optional(:referral_activity_over_all_verification_status).maybe(:string)
      end

      # Will be present if household member is being referred.
      # TODO: Fix these rules later
      rule(:referral_id) do
        # key.failure(text: 'Referral ID is invalid') if key? && value
      end
      rule(:referral_date) do
        # key.failure(text: 'Referral Date/Time is invalid') if key? && value
      end
      rule(:referral_activity_status) do
        # key.failure(text: 'Referral Activity Status Code is invalid') if key? && value
      end
    end
  end
end
