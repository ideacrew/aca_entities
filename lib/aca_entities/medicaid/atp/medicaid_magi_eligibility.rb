# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MedicaidMagiEligibility
      class MedicaidMagiEligibility < Dry::Struct

        attribute :eligibility_determination, EligibilityDetermination.optional.meta(omittable: true)
      end
    end
  end
end