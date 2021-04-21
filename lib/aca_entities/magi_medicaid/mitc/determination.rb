# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Determination < Dry::Struct

        # @!attribute [r] dependent_age
        # @return [DependentAge]
        attribute :dependent_age, DependentAge.meta(omittable: true)
      end
    end
  end
end
