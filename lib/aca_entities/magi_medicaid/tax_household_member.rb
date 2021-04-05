# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for TaxHouseholdMember.
    class TaxHouseholdMember < Dry::Struct

      attribute :product_eligibility_determination, ProductEligibilityDetermination.optional.meta(omittable: true)
      attribute :applicant_reference, Types::String.optional.meta(omittable: true)
    end
  end
end
