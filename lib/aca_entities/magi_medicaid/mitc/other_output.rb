# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class OtherOutput < Dry::Struct
        # @!attribute [r] qualified_children_list
        # An array of QualifiedChildren.
        # @return [Array<QualifiedChild>]
        attribute :qualified_children_list, Types::Array.of(QualifiedChild).meta(omittable: true)
      end
    end
  end
end
