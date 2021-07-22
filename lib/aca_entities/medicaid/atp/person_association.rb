# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonAssociation
      class PersonAssociation < Dry::Struct
        attribute :person, PersonReference.optional.meta(omittable: true)
        attribute :family_relationship_code, Types::FamilyRelationshipHIPAACode.optional.meta(omittable: true)
      end
    end
  end
end