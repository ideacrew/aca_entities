# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    class TaxHouseholdMemberEnrollmentMember < Dry::Struct

      attribute :hbx_enrollment_member, AcaEntities::Enrollments::HbxEnrollmentMember.meta(omittable: false)
      attribute :tax_household_member,  AcaEntities::Households::TaxHouseholdMember.meta(omittable: false)
      attribute :member_ehb_benchmark_health_premium,                             AcaEntities::Currency.meta(omittable: true)
      attribute :member_ehb_benchmark_dental_premium,                             AcaEntities::Currency.meta(omittable: true)
      attribute :age_on_effective_date,                                           Types::String.optional.meta(omittable: false)
    end
  end
end
