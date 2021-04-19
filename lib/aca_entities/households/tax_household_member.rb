# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdMember < Dry::Struct

      attribute :family_member_reference,
                AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: false)
      attribute :product_eligibility_determination,
                AcaEntities::Determinations::ProductEligibilityDetermination.optional.meta(omittable: false)
      attribute :is_subscriber,                                   Types::Bool.optional.meta(omittable: false)
      attribute :reason,                                          Types::String.optional.meta(omittable: false)
    end
  end
end

