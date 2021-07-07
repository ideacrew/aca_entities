# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A relationship A data type for a relationship between an employer and an employee.
          class PersonAssociation
            include HappyMapper

            tag 'PersonAssociation'
            namespace 'hix-core'

            has_one :begin_date, AssociationBeginDate
            has_one :end_date, AssociationEndDate
            has_one :person, PersonReference, :tag => 'PersonReference', namespace: "nc"

            # A kind of family relationship between two people.
            element :family_relationship_code, Integer, tag: 'FamilyRelationshipCode', namespace: "hix-core"

            # An indication of whether a person is a dependent deprived of parental support
            # whose care is provided by a caretaker under Medicaid rules, including the dependent's health coverage status.
            element :caretaker_dependent_code, String, tag: 'PersonCaretakerDependentCode', namespace: "hix-core"

            def self.domain_to_mapper(person_association)
              mapper = self.new
              mapper.begin_date = AssociationBeginDate.domain_to_mapper(person_association.begin_date)
              mapper.end_date = AssociationEndDate.domain_to_mapper(person_association.end_date)
              mapper.person = PersonReference.domain_to_mapper(person_association.person)
              mapper
            end

            def to_hash
              {
                relative_id: person ? person.to_hash[:ref] : nil,
                family_relationship_code: family_relationship_code,
                caretaker_dependent_code: caretaker_dependent_code
              }
            end
          end
        end
      end
    end
  end
end