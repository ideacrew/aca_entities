# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MedicaidMagiIncomeEligibilityBasis
      class MedicaidMagiIncomeEligibilityBasis < Dry::Struct

        attribute :status_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :eligibility_basis_status_code, Types::String.meta(omittable: false)
        attribute :ineligibility_reason_text, Types::String.optional.meta(omittable: true)
        attribute :eligibility_basis_determination, EligibilityBasisDetermination.optional.meta(omittable: true)
        attribute :state_threshold_fpl_percent, Types::String.optional.meta(omittable: true)
        attribute :income_compatibility, IncomeCompatibility.optional.meta(omittable: true)
      end
    end
  end
end