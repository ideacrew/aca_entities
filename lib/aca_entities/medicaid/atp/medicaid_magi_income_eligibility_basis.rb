# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MedicaidMagiIncomeEligibilityBasis
      class MedicaidMagiIncomeEligibilityBasis < EligibilityBasis

        # Additional attributes
        attribute :income_compatibility, IncomeCompatibility.optional.meta(omittable: true)
        attribute :state_threshold_fpl_percent, Types::String.optional.meta(omittable: true)
      end
    end
  end
end