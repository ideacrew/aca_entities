# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class Person
              include HappyMapper
              register_namespace 'ssac', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'Person'
              namespace 'ssac'

              element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification', namespace: "ssac"
              has_one :PersonName, PersonName
              has_one :PersonBirthDate, PersonBirthDate

              def self.domain_to_mapper(person)
                mapper = self.new
                mapper.PersonSSNIdentification = person.PersonSSNIdentification
                mapper.PersonName = PersonName.domain_to_mapper(person.PersonName)
                mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(person.PersonBirthDate)

                mapper
              end
            end
          end
        end
      end
    end
  end
end