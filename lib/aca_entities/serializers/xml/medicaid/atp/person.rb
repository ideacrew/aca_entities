# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class Person
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Person'
            namespace 'hix-core'

            has_one :person_name, PersonName

            def self.domain_to_mapper(applicant)
              mapper = self.new
              mapper.person_name = PersonName.domain_to_mapper(applicant)
              mapper
            end
          end
        end
      end
    end
  end
end