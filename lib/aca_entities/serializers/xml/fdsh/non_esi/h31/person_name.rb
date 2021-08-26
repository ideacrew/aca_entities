# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class PersonName
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'PersonName'
              namespace 'vnem'

              element :PersonGivenName, String, tag: 'PersonGivenName', namespace: 'vnem'
              element :PersonMiddleName, String, tag: 'PersonMiddleName', namespace: 'vnem'
              element :PersonSurName, String, tag: 'PersonSurName', namespace: 'vnem'
              element :PersonNameSuffixText, String, tag: 'PersonNameSuffixText', namespace: 'vnem'

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
