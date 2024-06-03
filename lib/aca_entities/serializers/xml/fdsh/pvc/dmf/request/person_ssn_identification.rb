# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Request
              # Happymapper implementation for the root object of an Request.
              class PersonSSNIdentification
                include HappyMapper
                register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

                tag 'PersonSSNIdentification'
                namespace 'nc'

                element :SSNIdentification, String, tag: 'SSNIdentification', namespace: 'ext'

                def self.domain_to_mapper(person_ssn)
                  mapper = self.new
                  mapper.SSNIdentification = person_ssn.SSNIdentification

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
