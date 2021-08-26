# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3

            # Include XML element and type definitions.
            class PersonName
              include HappyMapper
              register_namespace 'ssac', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'PersonName'
              namespace 'ssac'

              element :PersonGivenName, String, tag: "PersonGivenName", namespace: "ssac"
              element :PersonMiddleName, String, tag: "PersonMiddleName", namespace: "ssac"
              element :PersonSurName, String, tag: "PersonSurName", namespace: "ssac"

              def self.domain_to_mapper(person_name)
                mapper = self.new
                mapper.PersonGivenName = person_name.PersonGivenName
                mapper.PersonMiddleName = person_name.PersonMiddleName
                mapper.PersonSurName = person_name.PersonSurName

                mapper
              end
            end

          end
        end
      end
    end
  end
end