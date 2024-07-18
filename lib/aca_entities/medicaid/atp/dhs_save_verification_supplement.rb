# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for DhsSaveVerificationSupplement
      class DhsSaveVerificationSupplement < Dry::Struct
        attribute :step_id,                                Types::String.optional.meta(omittable: true)
        attribute :lawful_presence_verification_code,      Types::FfeVerificationCode.optional.meta(omittable: true)
        attribute :five_year_bar_verification_code,        Types::FfeVerificationCode.optional.meta(omittable: true)
        attribute :qualified_non_citizen_verification_code, Types::FfeVerificationCode.optional.meta(omittable: true)
        attribute :five_year_bar_met_verification_code,    Types::FfeVerificationCode.optional.meta(omittable: true)
        attribute :us_citizenship_verification_code,       Types::FfeVerificationCode.optional.meta(omittable: true)
        attribute :immigration_status_grant_dates,         Types::Array.of(Date).optional.meta(omittable: true)
      end
    end
  end
end