# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
            # Happymapper implementation for the root object of an Request.
              class PersonName
                include HappyMapper

                tag 'PersonName'

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
  end
end
