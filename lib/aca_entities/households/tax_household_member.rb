# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdMember < Dry::Struct

      attribute :family_member_reference,
                AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: true)
      attribute :product_eligibility_determination,
                AcaEntities::Determinations::ProductEligibilityDetermination.optional.meta(omittable: true)
      attribute :is_subscriber,           Types::Bool.optional.meta(omittable: true)
      attribute :relation_with_primary,   Types::String.optional.meta(omittable: true)
      attribute :tax_filer_status,        AcaEntities::Types::TaxFilerKind.optional.meta(omittable: true)
      attribute :slcsp_benchmark_premium, AcaEntities::Currency.meta(omittable: true)
      attribute :reason,                  Types::String.optional.meta(omittable: true)

    end
  end
end
