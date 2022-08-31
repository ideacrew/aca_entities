# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    class TaxHouseholdEnrollment < Dry::Struct

      attribute :tax_household_reference,                                   AcaEntities::Households::TaxHouseholdReference.meta(omittable: false)
      attribute :hbx_enrollment_reference,                                  AcaEntities::Enrollments::HbxEnrollmentReference.meta(omittable: false)
      attribute :health_product_hios_id,                                    Types::String.optional.meta(omittable: true)
      attribute :dental_product_hios_id,                                    Types::String.optional.meta(omittable: true)
      attribute :household_benchmark_ehb_premium,                           AcaEntities::Currency.meta(omittable: false)
      attribute :household_health_benchmark_ehb_premium,                    AcaEntities::Currency.optional.meta(omittable: true)
      attribute :household_dental_benchmark_ehb_premium,                    AcaEntities::Currency.optional.meta(omittable: true)

      attribute :tax_household_members_enrollment_members,
                Types::Array.of(AcaEntities::PremiumCredits::TaxHouseholdMemberEnrollmentMember).meta(omittable: false)
    end
  end
end
