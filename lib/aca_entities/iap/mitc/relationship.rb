# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      class Relationship < Dry::Struct

        # the person ID of the other person
        attribute :other_id,  Types::Integer.meta(ommittable: false)
        attribute :attest_primary_responsibility, Types::YesNoKind.meta(ommittable: false)
        attribute :relationship_code, Types::RelationshipCodeKind.meta(ommittable: false)

      end
    end
  end
end
