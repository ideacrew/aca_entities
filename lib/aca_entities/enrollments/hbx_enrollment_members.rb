# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentMembers < Dry::Struct

      attribute :family_member,             AcaEntities::Families::FamilyMemberReference.meta(omittable: false)
      attribute :is_subscriber,             Types::Strict::Bool.meta(omittable: false)
      # looks like this is member hbx_id associated with carrier
      attribute :carrier_member_id,         Types::String.optional.meta(omittable: false)
      attribute :premium_amount,            AcaEntities::Curreny.meta(omittable: false)
      attribute :applied_aptc_amount,       AcaEntities::Curreny.meta(omittable: false)
      attribute :eligibility_date,          Types::Date.meta(omittable: false)
      attribute :coverage_start_on,         Types::Date.meta(omittable: false)
      attribute :coverage_end_on,           Types::Date.optional.meta(omittable: false)
    end
  end
end