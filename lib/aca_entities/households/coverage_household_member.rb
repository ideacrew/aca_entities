# frozen_string_literal: true

module AcaEntities
  module Households
    class CoverageHouseholdMember < Dry::Struct

      #enroll, instead of family can we replace with person hbx_id
      attribute :family_member,                            AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: false)
      attribute :is_subscriber,                            Types::Bool.meta(omittable: false)
    end
  end
end
