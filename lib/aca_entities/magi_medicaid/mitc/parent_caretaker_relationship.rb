# frozen_string_literal: true

# TODO: verify the attributes.
module AcaEntities
  module MagiMedicaid
    module Mitc
      class ParentCaretakerRelationship < Dry::Struct

        # @!attribute [r] qualify_for_parent_caretaker_status
        # Does the person have the necessary relationship with the containing person to qualify the containing person for parent-caretaker status?
        # @return [Integer]
        attribute :qualify_for_parent_caretaker_status,     Types::YesNoKind.meta(omittable: false)
      end
    end
  end
end
