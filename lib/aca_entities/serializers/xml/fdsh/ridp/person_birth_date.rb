# frozen_string_literal: true

# require "aca_entities/serializers/xml/fdsh/ridp/person_name"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Include XML element and type definitions.
          class PersonBirthDate
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonBirthDate'
            namespace 'nc'

            element :date, Date, tag: "Date", namespace: "nc"

            def self.domain_to_mapper(person_birth_date)
              mapper = self.new
              mapper.date = person_birth_date
              mapper
            end
          end
        end
      end
    end
  end
end
