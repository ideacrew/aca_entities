# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Relationship < Dry::Struct

        # the person ID of the other person
        attribute :other_id,  Types::String.meta(omittable: false)
        attribute :attest_primary_responsibility, Types::YesNoKind.meta(omittable: false)
        attribute :relationship_code, Types::RelationshipCodeKind.meta(omittable: false)

      end
    end
  end
end
