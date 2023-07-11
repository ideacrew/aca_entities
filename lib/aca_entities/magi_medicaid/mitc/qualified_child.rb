# frozen_string_literal: true

# TODO: verify the attributes.
module AcaEntities
  module MagiMedicaid
    module Mitc
      class QualifiedChild < Dry::Struct

        # @!attribute [r] person_id
        # An integer representing the applicant.
        # @return [Integer]
        attribute :person_id,      Types::String.meta(omittable: false)

        # @!attribute [r] determination
        # Determinations: a hash containing only:
        #   a) Dependent Age: a hash with only the hash:
        #     i) Indicator: is the person of Dependent Age.  Y/N
        # @return [Hash]
        attribute :determination,   Determination.meta(omitttable: false)

        # @!attribute [r] deprived_child
        # Deprived Child: a hash with only the hash:
        #   a) Indicator: does the person qualify as a Deprived Child.  Y/N
        # @return [Hash]
        attribute :deprived_child,  DeprivedChild.meta(omittable: false)

        # @!attribute [r] parent_caretaker_relationship
        # Relationship: a hash with only the hash:
        # a) Indicator: does the person have the necessary relationship with the containing person
        # to qualify the containing person for parent-caretaker status.  Y/N
        # @return [Hash]
        attribute :parent_caretaker_relationship,   ParentCaretakerRelationship.meta(omittable: true)
      end
    end
  end
end
