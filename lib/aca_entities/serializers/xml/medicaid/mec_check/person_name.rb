# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a PersonName.
          class PersonName
            include HappyMapper

            tag 'PersonName'
            namespace 'gov'

            element :first_name, String, tag: "FirstName", namespace: "gov"
            element :middle_name, String, tag: "MiddleName", namespace: "gov"
            element :last_name, String, tag: "LastName", namespace: "gov"
            element :name_suffix, String, tag: "NameSuffix", namespace: "gov"

            def self.domain_to_mapper(person_name)
              mapper = self.new
              mapper.first_name = person_name.first_name
              mapper.middle_name = person_name.middle_name
              mapper.last_name = person_name.last_name
              mapper.name_suffix = person_name.name_suffix
              mapper
            end

            def to_hash
              {
                first_name: first_name,
                middle_name: middle_name,
                last_name: last_name,
                name_suffix: name_suffix
              }
            end
          end
        end
      end
    end
  end
end