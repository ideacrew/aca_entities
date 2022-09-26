# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class CategoryDetermination < Dry::Struct

        # @!attribute [r] category
        # In which category the other attributes map to.
        # @return [Types::CategoryDeterminationKind]
        attribute :category,        Types::CategoryDeterminationKind.meta(omittable: false)

        # @!attribute [r] indicator_code
        # Whether the {Applicant} qualifies for the category.
        # One character code, Y for yes, N for No, X for doesn't apply
        # @return [Types::Mitc::DeterminationIndicatorKind]
        attribute :indicator_code,        Types::DeterminationIndicatorKind.meta(omittable: false)

        # @!attribute [r] ineligibility_code
        # An FFM code.  3 digit code
        # One character code, Y for yes, N for No, X for doesn't apply
        # @return [Integer]
        attribute :ineligibility_code,    Types::Integer.optional.meta(omittable: true)

        # @!attribute [r] ineligibility_reason
        # A string describing why the {Applicant} is ineligible
        # @example
        #   Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21
        # @return [String]
        attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)

      end
    end
  end
end
