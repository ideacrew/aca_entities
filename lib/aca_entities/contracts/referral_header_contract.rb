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

        optional(:sender).maybe(:hash)
        optional(:receiver).maybe(:hash)
      end

      rule(:sender) do
        if key? && value
          if value.is_a?(Hash)
            result = SenderContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid sender', error: result.errors.to_h)
            else
              values.merge!(sender: result.to_h)
            end
          else
            key.failure(text: 'invalid sender. Expected a hash.')
          end
        end
      end

      rule(:receiver) do
        if key? && value
          if value.is_a?(Hash)
            result = ReceiverContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid receiver', error: result.errors.to_h)
            else
              values.merge!(receiver: result.to_h)
            end
          else
            key.failure(text: 'invalid receiver. Expected a hash.')
          end
        end
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
