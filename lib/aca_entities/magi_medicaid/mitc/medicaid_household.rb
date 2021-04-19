# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class MedicaidHousehold < Dry::Struct

        # @!attribute [r] people
        # A list of person references.
        # @return [Array<PersonReference>]
        attribute :people,        Types::Array.of(PersonReference).meta(omittable: false)

        # @!attribute [r] magi_income
        # The Modified Adjusted Gross Income for the household, expressed as a dollar amount.
        # @return [Integer]
        attribute :magi_income,   Types::Integer.meta(omittable: false)

        # @!attribute [r] size
        # The number of people in the household.
        # @return [Integer]
        attribute :size,          Types::Integer.meta(omittable: false)
      end
    end
  end
end
