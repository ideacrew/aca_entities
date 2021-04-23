# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class DependentAge < Dry::Struct

        # @!attribute [r] is_person_of_dependent_age
        # A string representing if the person of DependentAge.
        # @return [String]
        attribute :is_person_of_dependent_age, Types::YesNoKind.meta(omittable: true)
      end
    end
  end
end
