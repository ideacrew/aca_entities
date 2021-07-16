# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ChipIncomeEligibilityBasis
      class ChipIncomeEligibilityBasis < Dry::Struct

        attribute :status_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :status_code,      Types::EligibilityBasisStatusCode.meta(omittable: false)
        # attribute :inconsistency_reason,         Types::String.optional.meta(omittable: true)
        # attribute :ineligibility_reason,         Types::String.optional.meta(omittable: true)
        # attribute :status_determination_date,    Types::DateTime.optional.meta(omittable: true)
        # attribute :applicable_chip_standard,     Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
