# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class Person
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'Person'
              namespace 'ext'

              has_one :PersonName, PersonName
              has_one :PersonSSNIdentification, PersonSsnIdentification

              def self.domain_to_mapper(person)
                mapper = self.new
                mapper.PersonName = PersonName.domain_to_mapper(person.PersonName)
                mapper.PersonSSNIdentification = PersonSsnIdentification.domain_to_mapper(person.PersonSSNIdentification)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
