# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 MagiMedicaid Entity for CategoryDetermination.
    class CategoryDetermination < Dry::Struct

      # @!attribute [r] category
      # In which category the other attributes map to.
      # @return [AcaEntities::MagiMedicaid::Mitc::Types::CategoryDeterminationKind]
      attribute :category, ::AcaEntities::MagiMedicaid::Mitc::Types::CategoryDeterminationKind.meta(omittable: false)

      # @!attribute [r] indicator_code
      # Whether the {Applicant} qualifies for the category.
      # indicator_code should also be able to accept nil i.e. Applicant is not applicable for this category
      # @return [Types::Mitc::DeterminationIndicatorKind]
      attribute :indicator_code, Types::Bool.optional.meta(omittable: false)

      # @!attribute [r] ineligibility_code
      # An FFM code.  3 digit code
      # @return [Integer]
      attribute :ineligibility_code,    Types::Integer.optional.meta(omittable: true)

      # @!attribute [r] ineligibility_reason
      # A string describing why the {Applicant} is ineligible
      # @return [String]
      attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)
    end
  end
end
