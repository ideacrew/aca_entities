# frozen_string_literal: true

module AcaEntities
  module Households
    class CoverageHouseholdMember < Dry::Struct

      attribute :family_member_reference,                  AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: false)
      attribute :is_subscriber,                            Types::Bool.meta(omittable: false)
    end
  end
end
