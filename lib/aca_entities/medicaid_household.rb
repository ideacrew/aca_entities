# frozen_string_literal: true

module AcaEntities
  # Entity for MedicaidHousehold
  class MedicaidHousehold < Dry::Struct
    attribute :household_income,       HouseholdIncome.optional.meta(omittable: true)
    attribute :household_composition,  HouseholdComposition.optional.meta(omittable: true)
  end
end
