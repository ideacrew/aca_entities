# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MedicaidMagiEligibility
      class MedicaidMagiEligibility < Dry::Struct

        attribute :eligibility_determination, EligibilityDetermination.optional.meta(omittable: true)
        attribute :eligibility_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :eligibility_reason_text, Types::String.optional.meta(omittable: true)
        attribute :income_eligibility_basis, MedicaidMagiIncomeEligibilityBasis.optional.meta(omittable: true)
      end
    end
  end
end