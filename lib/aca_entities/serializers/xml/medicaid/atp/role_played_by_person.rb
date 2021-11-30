# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A human being.
          class RolePlayedByPerson
            include HappyMapper

            tag 'RolePlayedByPerson'
            namespace 'hix-ee'

            has_one :person_name, PersonName
            has_one :birth_date, PersonBirthDate
            element :sex, String, tag: "PersonSexText", namespace: "nc"
            has_one :person_augmentation, PersonAugmentation

            def self.domain_to_mapper(role)
              mapper = self.new
              mapper.person_name = PersonName.domain_to_mapper(role.person_name)
              mapper.birth_date = PersonName.domain_to_mapper(role.birth_date)
              mapper.sex = role.sex
              mapper.person_augmentation = PersonAugmentation.domain_to_mapper(person.person_augmentation)
              mapper
            end

            def to_hash
              {
                person_name: person_name&.to_hash,
                sex: sex,
                birth_date: birth_date&.to_hash,
                augementation: person_augmentation&.to_hash
              }
            end
          end
        end
      end
    end
  end
end