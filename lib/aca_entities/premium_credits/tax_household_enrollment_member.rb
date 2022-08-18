# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    class TaxHouseholdEnrollmentMember < Dry::Struct

      attribute :hbx_enrollment_member_id,                                        AcaEntities::Enrollments::HbxEnrollmentMemberReference.meta(omittable: false)
      attribute :tax_household_member_id,                                         AcaEntities::Households::TaxHouseholdMemberReference.meta(omittable: false)
      attribute :member_ehb_benchmark_health_premium,                             AcaEntities::Curreny.meta(omittable: true)
      attribute :member_ehb_benchmark_dental_premium,                             AcaEntities::Curreny.meta(omittable: true)
      attribute :age_on_effective_date,                                           Types::String.optional.meta(omittable: false)
    end
  end
end
