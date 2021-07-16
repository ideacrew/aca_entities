# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp CHIPIncarcerationEligibilityBasis
      class ChipIncarcerationEligibilityBasis < Dry::Struct

        attribute :status_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :status_valid_date_range, StatusValidDateRange.optional.meta(omittable: true)
        attribute :status_code, Types::EligibilityBasisStatusCode.meta(omittable: false)
        attribute :ineligibility_reason_text, Types::String.optional.meta(omittable: true)
        attribute :inconsistency_reason_text, Types::String.optional.meta(omittable: true)
        attribute :pending_reason_text, Types::String.optional.meta(omittable: true)
        attribute :determination, EligibilityBasisDetermination.optional.meta(omittable: true)
      end
    end
  end
end
