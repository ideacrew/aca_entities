# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonAssociation
      class PersonAssociation < Dry::Struct
        attribute :person, PersonReference.optional.meta(omittable: true)
        attribute :family_relationship_code, Types::FamilyRelationshipHIPAACode.optional.meta(omittable: true)
        attribute :caretaker_dependent_code, Types::String.optional.meta(omittable: true)
        attribute :begin_date, AssociationBeginDate.optional.meta(omittable: true)
        attribute :end_date, AssociationEndDate.optional.meta(omittable: true)
      end
    end
  end
end