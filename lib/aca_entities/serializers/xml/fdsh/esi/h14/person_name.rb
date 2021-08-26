# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class PersonName
              include HappyMapper
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'PersonName'
              namespace 'nc'

              element :PersonGivenName, String, tag: 'PersonGivenName', namespace: 'nc'
              element :PersonMiddleName, String, tag: 'PersonMiddleName', namespace: 'nc'
              element :PersonSurName, String, tag: 'PersonSurName', namespace: 'nc'
              element :PersonNameSuffixText, String, tag: 'PersonNameSuffixText', namespace: 'nc'

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
end
