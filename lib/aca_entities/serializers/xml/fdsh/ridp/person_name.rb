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

            element :person_given_name, String, tag: 'PersonGivenName'
            element :person_sur_name, String, tag: 'PersonSurName'
            element :person_middle_name, String, tag: 'PersonMiddleName'
            element :person_name_suffix_text, String, tag: 'PersonNameSuffixText'

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.person_given_name = person.person_given_name
              mapper.person_sur_name = person.person_sur_name
              mapper.person_middle_name = person.person_middle_name
              mapper.person_name_suffix_text = person.person_name_suffix_text
              mapper
            end
          end
        end
      end
    end
  end
end