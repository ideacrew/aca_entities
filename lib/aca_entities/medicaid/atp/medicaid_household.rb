# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for MedicaidHousehold
      class MedicaidHousehold < Dry::Struct
        attribute :household_incomes,       Types::Array.of(HouseholdIncome).optional.meta(omittable: true)
        # attribute :household_composition,  HouseholdComposition.optional.meta(omittable: true)
        attribute :effective_person_quantity, Types::Integer.optional.meta(omittable: true)
        attribute :income_above_highest_applicable_magi_standard_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :household_member_references, Types::Array.of(HouseholdMemberReference).optional.meta(omittable: true)
        attribute :household_size_quantity, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
