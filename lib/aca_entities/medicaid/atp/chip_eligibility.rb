# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ChipEligibility
      class ChipEligibility < Dry::Struct

        attribute :trafficking_victim_category_eligibility_basis, ChipTraffickingVictimCategoryEligibilityBasis.optional.meta(omittable: true)
      end
    end
  end
end