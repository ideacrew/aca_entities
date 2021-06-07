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
            element :person_birth_date, Date, tag: 'PersonBirthDate'
            element :person_ssn_identification, String, tag: 'PersonSsnIdentification'

            def self.domain_to_mapper(person_data)
              mapper = self.new
              mapper.person_name = PersonName.domain_to_mapper(person_data)
              mapper.person_birth_date = person_data.person_birth_date
              mapper.person_ssn_identification = person_data.person_ssn_identification
              mapper
            end
          end
        end
      end
    end
  end
end