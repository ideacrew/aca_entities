# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for TaxHouseholdMember.
    class TaxHouseholdMember < Dry::Struct

      attribute :product_eligibility_determination, ProductEligibilityDetermination.optional.meta(omittable: true)
      attribute :applicant_reference, ApplicantReference.meta(omittable: false)
      attribute :is_subscriber,           Types::Bool.optional.meta(omittable: true)
      attribute :tax_filer_status,        ::AcaEntities::MagiMedicaid::Types::TaxFilerKind.optional.meta(omittable: true)

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

      def aptc_csr_eligible?
        product_eligibility_determination&.is_ia_eligible || product_eligibility_determination&.is_csr_eligible
      end

      def csr
        product_eligibility_determination&.csr
      end

      def age_on(date)
        dob = applicant_reference.dob
        age = date.year - dob.year

        if date.month < dob.month || (date.month == dob.month && date.day < dob.day)
          age - 1
        else
          age
        end
      end
    end
  end
end
