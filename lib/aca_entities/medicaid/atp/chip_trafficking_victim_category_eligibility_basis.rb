# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ChipTraffickingVictimCategoryEligibilityBasis
      class ChipTraffickingVictimCategoryEligibilityBasis < Dry::Struct

        attribute :status_indicator, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
