# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class RequestPerson
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'RequestPerson'
              namespace 'ext'

              has_one :PersonBirthDate, PersonBirthDate
              has_one :PersonName, PersonName
              element :PersonSexCode, String, tag: 'PersonSexCode', namespace: 'nc'
              has_one :PersonSSNIdentification, PersonSsnIdentification

              def self.domain_to_mapper(person)
                mapper = self.new
                mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(person.PersonBirthDate)
                mapper.PersonName = PersonName.domain_to_mapper(person.PersonName)
                mapper.PersonSexCode = person.PersonSexCode
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
