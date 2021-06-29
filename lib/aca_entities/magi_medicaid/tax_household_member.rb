# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for TaxHouseholdMember.
    class TaxHouseholdMember < Dry::Struct

      attribute :product_eligibility_determination, ProductEligibilityDetermination.optional.meta(omittable: true)
      attribute :applicant_reference, ApplicantReference.meta(omittable: false)

      # MagiMedicaid Category Determination for type Income
      def medicaid_cd_for_income
        return nil unless product_eligibility_determination
        product_eligibility_determination.medicaid_cd_for_income
      end

      # MedicaidChip Category Determination for type Income
      def chip_cd_for_income
        return nil unless product_eligibility_determination
        product_eligibility_determination.chip_cd_for_income
      end
    end
  end
end
