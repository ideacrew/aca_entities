# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Include XML element and type definitions.
          class Person
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Person'
            namespace 'hix-core'

            has_one :person_name, PersonName
            element :PersonBirthDate, Date, tag: 'PersonBirthDate'
            element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification'

            def self.domain_to_mapper(person_data)
              mapper = self.new
              mapper.person_name = PersonName.domain_to_mapper(person_data)
              mapper.PersonBirthDate = person_data.PersonBirthDate
              mapper.PersonSSNIdentification = person_data.PersonSSNIdentification
              mapper
            end
          end
        end
      end
    end
  end
end