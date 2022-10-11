# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    class TaxHouseholdMemberEnrollmentMember < Dry::Struct

      attribute :hbx_enrollment_member,     AcaEntities::Enrollments::HbxEnrollmentMember.meta(omittable: false)
      attribute :tax_household_member,      AcaEntities::Households::TaxHouseholdMember.meta(omittable: false)
      attribute :age_on_effective_date,     Types::Integer.optional.meta(omittable: false)
      attribute :family_member_reference,   AcaEntities::Families::FamilyMemberReference.meta(omittable: false)
      attribute :relationship_with_primary, Types::String.optional.meta(omittable: false)
      attribute :date_of_birth,             Types::Date.optional.meta(omittable: false)

    end
  end
end
