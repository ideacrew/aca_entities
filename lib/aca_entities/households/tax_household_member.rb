# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdMember < Dry::Struct

      attribute :family_member,                                   AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: true)
      attribute :product_eligibility_determination,
                AcaIndividual::Determination::ProductEligibilityDetermination.optional.meta(omittable: true)
      attribute :is_subscriber,                                   Types::Bool.optional.meta(omittable: false)
      attribute :reason,                                          Types::String.optional.meta(omittable: false)
    end
  end
end

