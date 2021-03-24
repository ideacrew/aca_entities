# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    class MedicaidHousehold < Dry::Struct

      # @!attribute [r] people
      # A list of person references.
      # @return [Array<PersonReference>]
      attribute :people,        Types::Array.of(PersonReference).meta(omittible: false)

      # @!attribute [r] magi_income
      # The Modified Adjusted Gross Income for the household, expressed as a dollar amount.
      # @return [Integer]
      attribute :magi_income,   Types::Integer.meta(omittible: false)

      # @!attribute [r] size
      # The number of people in the household.
      # @return [Integer]
      attribute :size,          Types::Integer.meta(omittible: false)
    end
  end
end
