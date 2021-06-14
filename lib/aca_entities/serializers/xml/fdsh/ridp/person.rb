# frozen_string_literal: true

# require "aca_entities/serializers/xml/fdsh/ridp/person_name"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Include XML element and type definitions.
          class Person
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'Person'
            namespace 'ext'

            has_one :PersonName, PersonName
            element :PersonBirthDate, Date, tag: 'PersonBirthDate', namespace: 'nc'
            element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification', namespace: 'nc'

            def self.domain_to_mapper(person_data)
              mapper = self.new
              mapper.PersonName = PersonName.domain_to_mapper(person_data.PersonName)
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
