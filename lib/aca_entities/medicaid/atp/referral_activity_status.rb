# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for ReferralActivityStatus
      class ReferralActivityStatus < Dry::Struct
        attribute :status_code, Types::ReferralActivityStatusCode
        attribute :overall_verification_status_code, Types::FfeVerificationCode.optional.meta(omittable: true)
        # attribute :valid_date_range, StatusValidDateRange.optional.meta(omittable: true)
      end
    end
  end
end
