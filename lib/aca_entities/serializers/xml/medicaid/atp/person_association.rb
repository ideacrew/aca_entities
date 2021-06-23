# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A relationship A data type for a relationship between an employer and an employee.
          class PersonAssociation
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'PersonAssociation'
            namespace 'hix-core'

            has_one :begin_date, AssociationBeginDate 
            has_one :end_date, AssociationEndDate 
            has_one :person, PersonReference

            # A kind of family relationship between two people.
            element :family_relationship_code, Integer, tag: 'FamilyRelationshipCode', namespace: "hix-core" 

            # An indication of whether a person is a dependent deprived of parental support 
            # whose care is provided by a caretaker under Medicaid rules, including the dependent's health coverage status.
            element :caretaker_dependent_code, String, tag: 'PersonCaretakerDependentCode', namespace: "hix-core" 

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash,
                person: person&.to_hash,
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