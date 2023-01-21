# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentMember < Dry::Struct

      attribute :family_member_reference,   AcaEntities::Families::FamilyMemberReference.meta(omittable: false)
      attribute :is_subscriber,             Types::Strict::Bool.meta(omittable: false)
      # looks like this is member hbx_id associated with carrier
      attribute :carrier_member_id,         Types::String.optional.meta(omittable: true)
      attribute :premium_amount,            AcaEntities::Currency.meta(omittable: true)
      attribute :applied_aptc_amount,       AcaEntities::Currency.meta(omittable: true)
      attribute :eligibility_date,          Types::Date.meta(omittable: false)
      attribute :coverage_start_on,         Types::Date.meta(omittable: false)
      attribute :coverage_end_on,           Types::Date.optional.meta(omittable: true)
      attribute :external_id,               Types::String.optional.meta(omittable: true)
      attribute :tobacco_use,               Types::String.optional.meta(omittable: true)
      attribute :non_tobacco_use_premium,   AcaEntities::Currency.optional.meta(omittable: true)
      attribute :slcsp_member_premium,      AcaEntities::Currency.optional.meta(omittable: true)
    end
  end
end

