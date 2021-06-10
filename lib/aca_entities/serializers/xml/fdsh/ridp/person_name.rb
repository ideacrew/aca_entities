# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonName
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonName'
            namespace 'nc'

            element :PersonGivenName, String, tag: 'PersonGivenName'
            element :PersonSurName, String, tag: 'PersonSurName'
            element :PersonMiddleName, String, tag: 'PersonMiddleName'
            element :PersonNameSuffixText, String, tag: 'PersonNameSuffixText'

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.PersonGivenName = person.PersonGivenName
              mapper.PersonSurName = person.PersonSurName
              mapper.PersonMiddleName = person.PersonMiddleName
              mapper.PersonNameSuffixText = person.PersonNameSuffixText
              mapper
            end
          end
        end
      end
    end
  end
end