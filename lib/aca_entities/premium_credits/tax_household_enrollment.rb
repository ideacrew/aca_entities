# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    class TaxHouseholdEnrollment < Dry::Struct

      attribute :tax_household_id,                                          AcaEntities::Households::TaxHouseholdReference.meta(omittable: false)
      attribute :hbx_enrollment_id,                                         AcaEntities::Enrollments::HbxEnrollmentReference.meta(omittable: false)
      attribute :health_product_hios_id,                                    Types::String.optional.meta(omittable: true)
      attribute :dental_product_hios_id,                                    Types::String.optional.meta(omittable: true)
      attribute :total_benchmark_ehb_premium,                               AcaEntities::Curreny.meta(omittable: false)
      attribute :tax_household_enrollment_members,                          Types::Array.of(AcaEntities::PremiumCredits::TaxHouseholdEnrollmentMember).meta(omittable: false)
    end
  end
end
