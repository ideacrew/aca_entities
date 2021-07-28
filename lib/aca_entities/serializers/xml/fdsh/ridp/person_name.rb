# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Include XML element and type definitions.
          class PersonName
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonName'
            namespace 'nc'

            element :PersonGivenName, String, tag: 'PersonGivenName'
            element :PersonMiddleName, String, tag: 'PersonMiddleName'
            element :PersonSurName, String, tag: 'PersonSurName'
            element :PersonNameSuffixText, String, tag: 'PersonNameSuffixText'

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.PersonGivenName = person.PersonGivenName
              mapper.PersonMiddleName = person.PersonMiddleName
              mapper.PersonSurName = person.PersonSurName
              mapper.PersonNameSuffixText = person.PersonNameSuffixText
              mapper
            end
          end
        end
      end
    end
  end
end
