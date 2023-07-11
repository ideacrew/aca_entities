# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Applicant < Dry::Struct

        # @!attribute [r] person_id
        # An integer representing the applicant.
        # @return [Integer]
        attribute :person_id,        Types::String.meta(omittable: false)

        # @!attribute [r] medicaid_household
        # A hash representing the household composition and MAGI determination.
        # @return [Hash]
        attribute :medicaid_household,   MedicaidHousehold.meta(omitttable: false)

        # @!attribute [r] is_medicaid_eligible
        # Is this person Medicaid eligible?
        # @return [String]
        attribute :is_medicaid_eligible,    Types::YesNoKind.meta(omittable: false)

        # @!attribute [r] is_chip_eligible
        # Is this person CHIP eligible?
        # @return [String]
        attribute :is_chip_eligible,  Types::YesNoKind.meta(omittable: false)

        # @!attribute [r] medicaid_ineligibility_reasons
        # A list of reasons the person is not Medicaid eligible.
        # @return [String]
        attribute :medicaid_ineligibility_reasons,   Types::Array.of(Types::String).meta(omittable: false)

        # @!attribute [r] is_eligible_for_non_magi_reasons
        # Is the person potentially eligible for non-MAGI reasons?
        # @return [String]
        attribute :is_eligible_for_non_magi_reasons,  Types::YesNoKind.meta(omittable: false)

        # @!attribute [r] chip_ineligibility_reasons
        # A list of reasons the person is not CHIP eligible.
        # @return [String]
        attribute :chip_ineligibility_reasons,   Types::Array.of(Types::String).meta(omittable: false)

        # @!attribute [r] medicaid_category
        # The category under which the person may be found eligible for Medicaid.
        # If there are multiple qualifying categories, the highest-threshold category will be used.
        # If not eligible under any category, the value will be "None".
        # @return [String]
        attribute :medicaid_category,    Types::String.meta(omittable: false)

        # @!attribute [r] medicaid_category_threshold
        # The cutoff threshold for eligibility for this category.  Expressed in dollar amount.
        # @return [String]
        attribute :medicaid_category_threshold,    Types::Integer.meta(omittable: false)

        # @!attribute [r] chip_category
        # The category undwer which the person could be CHIP eligible.
        # This will be the largest threshold for which they're eligble.
        # If not eligible under any category, the value willbe "None".
        # @return [String]
        attribute :chip_category,    Types::String.meta(omittable: false)

        # @!attribute [r] chip_category_threshold
        # The cutoff threshold for eligibility for the qualifying category.  Expressed in dollar amount.
        # @return [String]
        attribute :chip_category_threshold,    Types::Integer.meta(omittable: false)

        # @!attribute [r] determinations
        # An array of category determinations.
        # @return [Array<CategoryDetermination>]
        attribute :determinations, Types::Array.of(CategoryDetermination).meta(omittable: false)

        # @!attribute [r] other_output
        # A list that currently contains only the Qualified Children List.
        # @return [OtherOutput]
        attribute :other_output,    OtherOutput.meta(omittable: false)
      end
    end
  end
end
